import type { PluginListenerHandle } from '@capacitor/core';

import type {
  PlayerCompletedEvent,
  PlayerErrorEvent,
  PlayerLoadedEvent,
  PlayerPausedEvent,
  PlayerPositionUpdatedEvent,
  PlayerSeekedEvent,
  PlayerStartedEvent,
  PlayerStoppedEvent,
  PlayerUnloadedEvent,
  ConfigureSessionOptions,
  EventListener,
  GetResponse,
  GetStateOptions,
  GetStateResponse,
  PauseAllForInterruptionResponse,
  PauseOptions,
  PauseResponse,
  PlayOptions,
  PlayResponse,
  PreloadOptions,
  PreloadResponse,
  ResumeAllAfterInterruptionResponse,
  ResumeOptions,
  ResumeResponse,
  SeekOptions,
  SeekResponse,
  SessionInterruptedEvent,
  SessionRouteChangedEvent,
  SetEnablePositionUpdatesOptions,
  SetEnablePositionUpdatesResponse,
  SetNumberOfLoopsOptions,
  SetNumberOfLoopsResponse,
  SetPositionUpdateIntervalOptions,
  SetPositionUpdateIntervalResponse,
  SetRateOptions,
  SetRateResponse,
  SetVolumeOptions,
  SetVolumeResponse,
  StopOptions,
  StopResponse,
  UnloadOptions,
  UnloadResponse,
  PreloadMixerBackgroundOptions,
  PreloadMixerBackgroundResponse,
  UnloadMixerBackgroundOptions,
  UnloadMixerBackgroundResponse,
} from './types';

interface NativeAudioPlugin {
  configureSession(options: ConfigureSessionOptions): Promise<null>;
  pauseAllForInterruption(): Promise<PauseAllForInterruptionResponse>;
  resumeAllAfterInterruption(): Promise<ResumeAllAfterInterruptionResponse>;

  /**
   * Player
   */

  getPlayers(): Promise<GetResponse>;
  preload(options: PreloadOptions): Promise<PreloadResponse>;
  preloadMixerBackground(options: PreloadMixerBackgroundOptions): Promise<PreloadMixerBackgroundResponse>;
  unload(options: UnloadOptions): Promise<UnloadResponse>;
  unloadMixerBackground(options: UnloadMixerBackgroundOptions): Promise<UnloadMixerBackgroundResponse>;
  getState(options: GetStateOptions): Promise<GetStateResponse>;
  play(options: PlayOptions): Promise<PlayResponse>;
  resume(options: ResumeOptions): Promise<ResumeResponse>;
  pause(options: PauseOptions): Promise<PauseResponse>;
  stop(options: StopOptions): Promise<StopResponse>;
  seek(options: SeekOptions): Promise<SeekResponse>;
  setVolume(options: SetVolumeOptions): Promise<SetVolumeResponse>;
  setRate(options: SetRateOptions): Promise<SetRateResponse>;
  setNumberOfLoops(options: SetNumberOfLoopsOptions): Promise<SetNumberOfLoopsResponse>;
  setEnablePositionUpdates(options: SetEnablePositionUpdatesOptions): Promise<SetEnablePositionUpdatesResponse>;
  setPositionUpdateInterval(options: SetPositionUpdateIntervalOptions): Promise<SetPositionUpdateIntervalResponse>;

  /**
   * Event Listeners
   */
  addListener(
    eventName: 'sessionInterrupted',
    listenerFunc: (data: SessionInterruptedEvent) => void,
  ): Promise<PluginListenerHandle>;

  addListener(
    eventName: 'sessionRouteChanged',
    listenerFunc: (data: SessionRouteChangedEvent) => void,
  ): Promise<PluginListenerHandle>;

  /**
   * Add a listener for an event.
   */

  addListener(
    eventName: PlayerLoadedEvent['eventName'],
    listenerFunc: EventListener<PlayerLoadedEvent>,
  ): Promise<PluginListenerHandle>;

  addListener(
    eventName: PlayerUnloadedEvent['eventName'],
    listenerFunc: EventListener<PlayerUnloadedEvent>,
  ): Promise<PluginListenerHandle>;

  addListener(
    eventName: PlayerStartedEvent['eventName'],
    listenerFunc: EventListener<PlayerStartedEvent>,
  ): Promise<PluginListenerHandle>;

  addListener(
    eventName: PlayerPausedEvent['eventName'],
    listenerFunc: EventListener<PlayerPausedEvent>,
  ): Promise<PluginListenerHandle>;

  addListener(
    eventName: PlayerStoppedEvent['eventName'],
    listenerFunc: EventListener<PlayerStoppedEvent>,
  ): Promise<PluginListenerHandle>;

  addListener(
    eventName: PlayerSeekedEvent['eventName'],
    listenerFunc: EventListener<PlayerSeekedEvent>,
  ): Promise<PluginListenerHandle>;

  addListener(
    eventName: PlayerCompletedEvent['eventName'],
    listenerFunc: EventListener<PlayerCompletedEvent>,
  ): Promise<PluginListenerHandle>;

  addListener(
    eventName: PlayerErrorEvent['eventName'],
    listenerFunc: EventListener<PlayerErrorEvent>,
  ): Promise<PluginListenerHandle>;

  addListener(
    eventName: PlayerPositionUpdatedEvent['eventName'],
    listenerFunc: EventListener<PlayerPositionUpdatedEvent>,
  ): Promise<PluginListenerHandle>;
}

export { NativeAudioPlugin };
