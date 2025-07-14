type AVAudioSessionCategory = 'ambient' | 'multiRoute' | 'playAndRecord' | 'playback' | 'record' | 'soloAmbient';

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

type AVAudioSessionCategoryOptions =
  | 'mixWithOthers'
  | 'duckOthers'
  | 'interruptSpokenAudioAndMixWithOthers'
  | 'allowBluetoothA2DP'
  | 'allowAirPlay'
  | 'defaultToSpeaker'
  | 'overrideMutedMicrophoneInterruption';

export interface ConfigureSessionOptions {
  enableAutoInterruptionHandling?: boolean;
  enableAutoIosSessionDeactivation?: boolean;
  positionUpdateInterval?: number;
  iosCategory?: AVAudioSessionCategory;
  iosMode?: AVAudioSessionMode;
  iosOptions?: AVAudioSessionCategoryOptions[];
}

export interface PauseAllAssetsResponse {
  pausedAssetIds: string[];
}

export interface ResumeAllAssetsResponse {
  resumedAssetIds: string[];
}

/**
 * Asset
 */

export interface GetAssetsResponse {
  assets: string[];
}

export interface PreloadAssetOptions {
  assetId: string;
  source: string;
  volume?: number;
  rate?: number;
  numberOfLoops?: number;
}

export interface PreloadAssetResponse {
  assetId: string;
  duration: number;
}

export interface UnloadAssetOptions {
  assetId: string;
}

export interface UnloadAssetResponse {
  assetId: string;
}

export interface GetAssetStateOptions {
  assetId: string;
}

export interface GetAssetStateResponse {
  assetId: string;
  isPlaying: boolean;
  currentTime: number;
  duration: number;
}

export interface PlayAssetOptions {
  assetId: string;
}

export interface PlayAssetResponse {
  assetId: string;
  isPlaying: boolean;
}

export interface PauseAssetOptions {
  assetId: string;
}

export interface PauseAssetResponse {
  assetId: string;
  isPlaying: boolean;
}

export interface StopAssetOptions {
  assetId: string;
}

export interface StopAssetResponse {
  assetId: string;
  isPlaying: boolean;
}

export interface SeekAssetOptions {
  assetId: string;
  time: number;
}

export interface SeekAssetResponse {
  assetId: string;
  currentTime: number;
}

export interface SetAssetVolumeOptions {
  assetId: string;
  volume: number;
}

export interface SetAssetVolumeResponse {
  assetId: string;
  volume: number;
}

export interface SetAssetRateOptions {
  assetId: string;
  rate: number;
}

export interface SetAssetRateResponse {
  assetId: string;
  rate: number;
}

export interface SetAssetNumberOfLoopsOptions {
  assetId: string;
  numberOfLoops: number;
}

export interface SetAssetNumberOfLoopsResponse {
  assetId: string;
  numberOfLoops: number;
}

export type EventListener<T> = (data: T) => void;

export interface SessionInterruptedEvent {
  eventName: 'sessionInterrupted';
  state: 'began' | 'ended';
}

export interface SessionRouteChangedEvent {
  eventName: 'sessionRouteChanged';
  reason: number;
}

export interface AssetLoadedEvent {
  eventName: 'assetLoaded';
  assetId: string;
  duration: number;
}

export interface AssetUnloadedEvent {
  eventName: 'assetUnloaded';
  assetId: string;
}

export interface AssetStartedEvent {
  eventName: 'assetStarted';
  assetId: string;
}

export interface AssetPausedEvent {
  eventName: 'assetPaused';
  assetId: string;
}

export interface AssetStoppedEvent {
  eventName: 'assetStopped';
  assetId: string;
}

export interface AssetSeekedEvent {
  eventName: 'assetSeeked';
  assetId: string;
  currentTime: number;
}

export interface AssetCompletedEvent {
  eventName: 'assetCompleted';
  assetId: string;
}

export interface AssetErrorEvent {
  eventName: 'assetError';
  assetId: string;
  error: string;
}

export interface AssetPositionUpdateEvent {
  eventName: 'assetPositionUpdate';
  assetId: string;
  currentTime: number;
}
