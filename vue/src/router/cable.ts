import {createConsumer} from "@rails/actioncable"
import {onMounted, onUnmounted} from 'vue';


const cable = createConsumer("ws://localhost:3000/cable")

type ConnectionCallback = () => void
type DisconnectionCallback = () => void
type ReceivedCallback = (data: any) => void

type Callbacks = {
  connected?: ConnectionCallback,
  disconnected?: DisconnectionCallback,
  received?: ReceivedCallback,
}


export default function useCable(channelName: string, {connected, disconnected, received}: Callbacks | {} = {}) {
  const onConnected: ConnectionCallback[] = connected ? [connected] : []
  const onDisconnected: DisconnectionCallback[] = disconnected ? [disconnected] : []
  const onReceived: ReceivedCallback[] = received ? [received] : []
  let channel: any = undefined;

  onMounted(() => channel = cable.subscriptions.create(channelName, {
    connected: () => onConnected.forEach((c: ConnectionCallback) => c()),
    disconnected: () => onDisconnected.forEach((c: DisconnectionCallback) => c()),
    received: (data: any) => onReceived.forEach((c: ReceivedCallback) => c(data))
  }))

  onUnmounted(() => channel?.unsubscribe());

  return {
    channel,
    onReceived: (callback: ReceivedCallback) => onReceived.push(callback),
    unsubscribe: () => channel.unsubscribe()
  }
}
