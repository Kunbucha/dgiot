%%--------------------------------------------------------------------
%% Copyright (c) 2020-2021 DGIOT Technologies Co., Ltd. All Rights Reserved.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%--------------------------------------------------------------------

-module(dgiot_factory_channel).
-behavior(dgiot_channelx).
-author("kenneth").
-include_lib("dgiot/include/dgiot_socket.hrl").
-include_lib("dgiot/include/logger.hrl").
-include_lib("dgiot_bridge/include/dgiot_bridge.hrl").
-include("dgiot_factory.hrl").
-define(TYPE, <<"FACTORY">>).
-define(MAX_BUFF_SIZE, 1024).
-record(state, {id, mod, product, env = #{}}).
%% API
-export([start/2]).

%% Channel callback
-export([init/3, handle_init/1, handle_event/3, handle_message/2, stop/3]).


%% 注册通道类型
-channel_type(#{
    cType => ?TYPE,
    type => ?BACKEND_CHL,
    priority => 2,
    title => #{
        zh => <<"Device缓存通道"/utf8>>
    },
    description => #{
        zh => <<"Device缓存通道"/utf8>>
    }
}).
%% 注册通道参数
-params(#{
    <<"ico">> => #{
        order => 102,
        type => string,
        required => false,
        default => <<"/dgiot_file/shuwa_tech/zh/product/dgiot/channel/device_profile.png">>,
        title => #{
            en => <<"channel ICO">>,
            zh => <<"通道ICO"/utf8>>
        },
        description => #{
            en => <<"channel ICO">>,
            zh => <<"通道ICO"/utf8>>
        }
    }
}).


start(ChannelId, ChannelArgs) ->
    dgiot_channelx:add(?TYPE, ChannelId, ?MODULE, ChannelArgs).

%% 通道初始化
init(?TYPE, ChannelId,  Args) ->
    State = #state{
        id = ChannelId,
        env = Args
    },
    dgiot_parse_hook:subscribe(<<"Device">>, post, ChannelId),
    dgiot_parse_hook:subscribe(<<"Device/*">>, put, ChannelId, [<<"content">>]),
    dgiot_parse_hook:subscribe(<<"Device/*">>, delete, ChannelId),
    {ok, State, []}.

handle_init( State) ->
    {ok, State}.

%% 通道消息处理,注意：进程池调用
handle_event(_EventId, Event, State) ->
    ?LOG(info, "Channel ~p", [Event]),
    {ok, State}.


handle_message({sync_parse, _Pid, 'after', post, Token, <<"Device">>, QueryData}, State) ->
    dgiot_device:post(QueryData, Token),
    {ok, State};



%%handle_message({sync_parse, _Pid, 'before', put, Token, <<"Device">>, #{<<"content">> := Content,<<"id">> := DeviceId } = _QueryData},  #state{env =#{<<"product">> :=Product}} =State) ->
    handle_message({sync_parse, _Pid, 'before', put, Token, <<"Device">>, #{<<"content">> := Content,<<"id">> := DeviceId } = _QueryData},  State) ->
%%    lists:foldl(
%%        fun(X,_)->
%%            L = tuple_to_list(X),
%%            io:format("~s ~p length = ~p ~n",[?FILE,?LINE,length(L)]),
%%            F = lists:nth(1,L),
%%            io:format("~s ~p F = ~p ~n",[?FILE,?LINE,F])
%%            lists:foldl(
%%                fun(K,_)->
%%                    io:format("~s ~p Product= ~p ~n",[?FILE,?LINE,is_map(K)])
%%            end,[],L)
%%    end,[],Product),
    FlatMap = dgiot_map:flatten(Content),
    case Content of
        #{<<"person">>:= #{<<"type">> :=Type}} ->
            dgiot_factory_data:handle_data(DeviceId,Type,FlatMap#{<<"persion_sessiontoken">> => Token});
        _ ->
            pass
    end,
    {ok, State};


handle_message(Message, State) ->
    ?LOG(debug, "channel ~p", [Message]),
    {ok, State}.

stop(ChannelType, ChannelId, _State) ->
    ?LOG(warning, "Channel[~p,~p] stop", [ChannelType, ChannelId]),
    ok.



%%handle_content(Content,DeviceId)->
%%    case dgiot_device_cache:lookup(DeviceId) of
%%        {ok,#{<<"productid">> = ProductId}} ->
%%            SheetList = get_sheetlist(ProductId),
%%        maps:fold(
%%            fun(K,V,Acc) ->
%%                case lists:member(SheetList, K) of
%%                    true ->
%%
%%                        Acc;
%%                    false ->
%%                        Acc
%%                end
%%
%%        end ,[],Content);
%%        _ ->
%%            pass
%%    end.
%%

%%get_sheetlist(ProductId) ->
%%    case dgiot_product:lookup_prod(ProductId) of
%%        {ok, #{<<"thing">> := #{<<"properties">> := PropertiesList}}} ->
%%            Res =lists:foldl(
%%                fun(X, Acc) ->
%%                    case maps:find(<<"devicetype">>, X) of
%%                        {ok, Sheet} ->
%%                            case lists:member(Sheet, Acc) of
%%                                true ->
%%                                    Acc;
%%                                false ->
%%                                    Acc ++ [Sheet]
%%                            end;
%%                        _ ->
%%                            Acc
%%                    end
%%                end, [], PropertiesList),
%%            lists:delete(<<"person">>,Res);
%%        _ ->
%%            []
%%
%%    end.
