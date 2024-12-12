import 'package:flutter/cupertino.dart';
import 'package:pusher_client_fixed/pusher_client_fixed.dart';

class PusherService {
  late PusherClient _pusher;
  final Map<String, Channel> _subscribedChannels = {};

  PusherService(String apiKey, String cluster) {
    final pusherOptions = PusherOptions(
      cluster: cluster,
      encrypted: true,
    );

    _pusher = PusherClient(
      apiKey,
      pusherOptions,
    );

    _pusher.connect();
  }

  bool isSubscribedToChannel(String channelName) {
    return _subscribedChannels.containsKey(channelName);
  }

  void subscribeToChannel(String channelName, Map<String, String> events,
      Function(PusherEvent?) callback) {
    if (_subscribedChannels.containsKey(channelName)) {
      debugPrint('Already subscribed to channel: $channelName');
      return;
    }

    final channel = _pusher.subscribe(channelName);
    _subscribedChannels[channelName] = channel;

    events.forEach((eventName, eventDescription) {
      debugPrint("Subscribing to event: $eventName on channel: $channelName");
      channel.bind(eventName, (PusherEvent? event) {
        if (event != null) {
          debugPrint("Received event: $eventName with data: ${event.data}");
          callback(event);
        } else {
          debugPrint("Event received was null");
        }
      });
    });
  }

  void unsubscribeFromAllChannels() {
    _subscribedChannels.forEach((channelName, channel) {
      _pusher.unsubscribe(channelName);
    });
    _subscribedChannels.clear();
  }

  void disconnect() {
    _pusher.disconnect();
  }
}
