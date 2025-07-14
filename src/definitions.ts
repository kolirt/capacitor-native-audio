import type { PluginListenerHandle } from '@capacitor/core';

import type {
  ConfigureSessionOptions,
  GetAssetsResponse,
  PauseAllAssetsResponse,
  PreloadAssetOptions,
  PreloadAssetResponse,
  ResumeAllAssetsResponse,
  SetAssetRateOptions,
  SetAssetRateResponse,
  SetAssetVolumeOptions,
  SetAssetVolumeResponse,
  UnloadAssetOptions,
  UnloadAssetResponse,
  GetAssetStateOptions,
  GetAssetStateResponse,
  PauseAssetOptions,
  PauseAssetResponse,
  PlayAssetOptions,
  PlayAssetResponse,
  SeekAssetOptions,
  SeekAssetResponse,
  SetAssetNumberOfLoopsOptions,
  SetAssetNumberOfLoopsResponse,
  SetAssetEnablePositionUpdatesOptions,
  SetAssetEnablePositionUpdatesResponse,
  SetAssetPositionUpdateIntervalOptions,
  SetAssetPositionUpdateIntervalResponse,
  StopAssetOptions,
  StopAssetResponse,
  SessionInterruptedEvent,
  SessionRouteChangedEvent,
  AssetLoadedEvent,
  AssetUnloadedEvent,
  EventListener,
  AssetStartedEvent,
  AssetPausedEvent,
  AssetStoppedEvent,
  AssetSeekedEvent,
  AssetCompletedEvent,
  AssetErrorEvent,
  AssetPositionUpdateEvent,
} from './types';

interface NativeAudioPlugin {
  configureSession(options: ConfigureSessionOptions): Promise<null>;
  pauseAllAssets(): Promise<PauseAllAssetsResponse>;
  resumeAllAssets(): Promise<ResumeAllAssetsResponse>;

  /**
   * Asset
   */

  getAssets(): Promise<GetAssetsResponse>;
  preloadAsset(options: PreloadAssetOptions): Promise<PreloadAssetResponse>;
  unloadAsset(options: UnloadAssetOptions): Promise<UnloadAssetResponse>;
  getAssetState(options: GetAssetStateOptions): Promise<GetAssetStateResponse>;
  playAsset(options: PlayAssetOptions): Promise<PlayAssetResponse>;
  pauseAsset(options: PauseAssetOptions): Promise<PauseAssetResponse>;
  stopAsset(options: StopAssetOptions): Promise<StopAssetResponse>;
  seekAsset(options: SeekAssetOptions): Promise<SeekAssetResponse>;
  setAssetVolume(options: SetAssetVolumeOptions): Promise<SetAssetVolumeResponse>;
  setAssetRate(options: SetAssetRateOptions): Promise<SetAssetRateResponse>;
  setAssetNumberOfLoops(options: SetAssetNumberOfLoopsOptions): Promise<SetAssetNumberOfLoopsResponse>;
  setAssetEnablePositionUpdates(options: SetAssetEnablePositionUpdatesOptions): Promise<SetAssetEnablePositionUpdatesResponse>;
  setAssetPositionUpdateInterval(options: SetAssetPositionUpdateIntervalOptions): Promise<SetAssetPositionUpdateIntervalResponse>;

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
    eventName: AssetLoadedEvent['eventName'],
    listenerFunc: EventListener<AssetLoadedEvent>,
  ): Promise<PluginListenerHandle>;

  addListener(
    eventName: AssetUnloadedEvent['eventName'],
    listenerFunc: EventListener<AssetUnloadedEvent>,
  ): Promise<PluginListenerHandle>;

  addListener(
    eventName: AssetStartedEvent['eventName'],
    listenerFunc: EventListener<AssetStartedEvent>,
  ): Promise<PluginListenerHandle>;

  addListener(
    eventName: AssetPausedEvent['eventName'],
    listenerFunc: EventListener<AssetPausedEvent>,
  ): Promise<PluginListenerHandle>;

  addListener(
    eventName: AssetStoppedEvent['eventName'],
    listenerFunc: EventListener<AssetStoppedEvent>,
  ): Promise<PluginListenerHandle>;

  addListener(
    eventName: AssetSeekedEvent['eventName'],
    listenerFunc: EventListener<AssetSeekedEvent>,
  ): Promise<PluginListenerHandle>;

  addListener(
    eventName: AssetCompletedEvent['eventName'],
    listenerFunc: EventListener<AssetCompletedEvent>,
  ): Promise<PluginListenerHandle>;

  addListener(
    eventName: AssetErrorEvent['eventName'],
    listenerFunc: EventListener<AssetErrorEvent>,
  ): Promise<PluginListenerHandle>;

  addListener(
    eventName: AssetPositionUpdateEvent['eventName'],
    listenerFunc: EventListener<AssetPositionUpdateEvent>,
  ): Promise<PluginListenerHandle>;
}

export { NativeAudioPlugin };
