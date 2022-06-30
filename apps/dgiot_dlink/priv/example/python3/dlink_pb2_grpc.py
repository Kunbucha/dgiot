# Generated by the gRPC Python protocol compiler plugin. DO NOT EDIT!
"""Client and server classes corresponding to protobuf-defined services."""
import grpc

import dlink_pb2 as dlink__pb2


class DlinkStub(object):
    """The dlink service definition.
    """

    def __init__(self, channel):
        """Constructor.

        Args:
            channel: A grpc.Channel.
        """
        self.SayHello = channel.unary_unary(
                '/dgiot.Dlink/SayHello',
                request_serializer=dlink__pb2.HelloRequest.SerializeToString,
                response_deserializer=dlink__pb2.HelloReply.FromString,
                )
        self.Check = channel.unary_unary(
                '/dgiot.Dlink/Check',
                request_serializer=dlink__pb2.HealthCheckRequest.SerializeToString,
                response_deserializer=dlink__pb2.HealthCheckResponse.FromString,
                )
        self.Watch = channel.unary_stream(
                '/dgiot.Dlink/Watch',
                request_serializer=dlink__pb2.HealthCheckRequest.SerializeToString,
                response_deserializer=dlink__pb2.HealthCheckResponse.FromString,
                )


class DlinkServicer(object):
    """The dlink service definition.
    """

    def SayHello(self, request, context):
        """Sends a greeting
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def Check(self, request, context):
        """If the requested service is unknown, the call will fail with status
        NOT_FOUND.
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def Watch(self, request, context):
        """Performs a watch for the serving status of the requested service.
        The server will immediately send back a message indicating the current
        serving status.  It will then subsequently send a new message whenever
        the service's serving status changes.

        If the requested service is unknown when the call is received, the
        server will send a message setting the serving status to
        SERVICE_UNKNOWN but will *not* terminate the call.  If at some
        future point, the serving status of the service becomes known, the
        server will send a new message with the service's serving status.

        If the call terminates with status UNIMPLEMENTED, then clients
        should assume this method is not supported and should not retry the
        call.  If the call terminates with any other status (including OK),
        clients should retry the call with appropriate exponential backoff.
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')


def add_DlinkServicer_to_server(servicer, server):
    rpc_method_handlers = {
            'SayHello': grpc.unary_unary_rpc_method_handler(
                    servicer.SayHello,
                    request_deserializer=dlink__pb2.HelloRequest.FromString,
                    response_serializer=dlink__pb2.HelloReply.SerializeToString,
            ),
            'Check': grpc.unary_unary_rpc_method_handler(
                    servicer.Check,
                    request_deserializer=dlink__pb2.HealthCheckRequest.FromString,
                    response_serializer=dlink__pb2.HealthCheckResponse.SerializeToString,
            ),
            'Watch': grpc.unary_stream_rpc_method_handler(
                    servicer.Watch,
                    request_deserializer=dlink__pb2.HealthCheckRequest.FromString,
                    response_serializer=dlink__pb2.HealthCheckResponse.SerializeToString,
            ),
    }
    generic_handler = grpc.method_handlers_generic_handler(
            'dgiot.Dlink', rpc_method_handlers)
    server.add_generic_rpc_handlers((generic_handler,))


 # This class is part of an EXPERIMENTAL API.
class Dlink(object):
    """The dlink service definition.
    """

    @staticmethod
    def SayHello(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/dgiot.Dlink/SayHello',
            dlink__pb2.HelloRequest.SerializeToString,
            dlink__pb2.HelloReply.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def Check(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/dgiot.Dlink/Check',
            dlink__pb2.HealthCheckRequest.SerializeToString,
            dlink__pb2.HealthCheckResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def Watch(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_stream(request, target, '/dgiot.Dlink/Watch',
            dlink__pb2.HealthCheckRequest.SerializeToString,
            dlink__pb2.HealthCheckResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)