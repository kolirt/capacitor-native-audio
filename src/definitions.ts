import type { PluginListenerHandle } from '@capacitor/core';

type EventListener<T> = (data: T) => void;

type SessionInterruptedEvent = { eventName: 'sessionInterrupted'; state: 'began' | 'ended' };
type SessionRouteChangedEvent = { eventName: 'sessionRouteChanged'; reason: number };

type AssetLoadedEvent = { eventName: 'assetLoaded'; assetId: string; duration: number };
type AssetUnloadedEvent = { eventName: 'assetUnloaded'; assetId: string };
type AssetStartedEvent = { eventName: 'assetStarted'; assetId: string };
type AssetPausedEvent = { eventName: 'assetPaused'; assetId: string };
type AssetStoppedEvent = { eventName: 'assetStopped'; assetId: string };
type AssetSeekedEvent = { eventName: 'assetSeeked'; assetId: string; currentTime: number };
type AssetCompletedEvent = { eventName: 'assetCompleted'; assetId: string };
type AssetErrorEvent = { eventName: 'assetError'; assetId: string; error: string };
type AssetPositionUpdateEvent = { eventName: 'assetPositionUpdate'; assetId: string; currentTime: number };

type AVAudioSessionMode =
  | 'default'
  | 'gameChat'
  | 'measurement'
  | 'moviePlayback'
  | 'spokenAudio'
  | 'videoChat'
  | 'videoRecording'
  | 'voiceChat'
  | 'voicePrompt';

type AVAudioSessionCategory = 'ambient' | 'multiRoute' | 'playAndRecord' | 'playback' | 'record' | 'soloAmbient';

type AVAudioSessionCategoryOptions =
  | 'mixWithOthers'
  | 'duckOthers'
  | 'interruptSpokenAudioAndMixWithOthers'
  | 'allowBluetoothA2DP'
  | 'allowAirPlay'
  | 'defaultToSpeaker'
  | 'overrideMutedMicrophoneInterruption';

interface NativeAudioPlugin {
  configureSession(options: {
    enableAutoInterruptionHandling?: boolean;
    enableAutoIosSessionActivation?: boolean
    iosCategory?: string;
    iosMode?: string;
    iosOptions?: string[];
  }): Promise<{
    enableAutoHandling: boolean;
    iosCategory?: AVAudioSessionCategory;
    iosMode?: AVAudioSessionMode;
    iosOptions?: AVAudioSessionCategoryOptions[];
  }>;

  pauseAllAssets(): Promise<{ pausedAssetIds: string[] }>;

  resumeAllAssets(): Promise<{ resumedAssetIds: string[] }>;

  /**
   * Asset
   */

  getAssets(): Promise<{ assets: string[] }>;

  preloadAsset(options: {
    assetId: string;
    source: string;
    volume?: number;
    rate?: number;
    numberOfLoops?: number;
  }): Promise<{ assetId: string; duration: number }>;

  unloadAsset(options: { assetId: string }): Promise<{ assetId: string }>;

  getAssetState(options: {
    assetId: string;
  }): Promise<{ assetId: string; isPlaying: boolean; currentTime: number; duration: number }>;

  playAsset(options: { assetId: string }): Promise<{ assetId: string; isPlaying: boolean }>;

  pauseAsset(options: { assetId: string }): Promise<{ assetId: string; isPlaying: boolean }>;

  stopAsset(options: { assetId: string }): Promise<{ assetId: string; isPlaying: boolean }>;

  seekAsset(options: { assetId: string; time: number }): Promise<{ assetId: string; currentTime: number }>;

  setAssetVolume(options: { assetId: string; volume: number }): Promise<{ assetId: string; volume: number }>;

  setAssetRate(options: { assetId: string; rate: number }): Promise<{ assetId: string; rate: number }>;

  setAssetNumberOfLoops(options: {
    assetId: string;
    numberOfLoops: number;
  }): Promise<{ assetId: string; numberOfLoops: number }>;

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

export {
  AssetLoadedEvent,
  AssetUnloadedEvent,
  AssetStartedEvent,
  AssetPausedEvent,
  AssetStoppedEvent,
  AssetCompletedEvent,
  AssetErrorEvent,
  AssetPositionUpdateEvent,
  NativeAudioPlugin,
};
