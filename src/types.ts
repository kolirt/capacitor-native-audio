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
  /**
   * Automatically pause and resume all assets when the audio session is interrupted or resumed.
   *
   * @default true
   */
  enableAutoInterruptionHandling?: boolean;
  /**
   * Automatically deactivate the IOS audio session when all assets are paused or stopped.
   *
   * @default true
   */
  enableAutoIosSessionDeactivation?: boolean;
  /**
   * Unique identifier for the IOS audio session.
   * [docs](https://developer.apple.com/documentation/avfaudio/avaudiosession/category-swift.struct)
   */
  iosCategory?: AVAudioSessionCategory;
  /**
   * Unique identifier for the IOS audio session mode.
   * [docs](https://developer.apple.com/documentation/avfaudio/avaudiosession/mode-swift.struct)
   */
  iosMode?: AVAudioSessionMode;
  /**
   * Options for the IOS audio session category.
   * [docs](https://developer.apple.com/documentation/avfaudio/avaudiosession/categoryoptions-swift.struct)
   */
  iosOptions?: AVAudioSessionCategoryOptions[];
}

export interface PauseAllAssetsResponse {
  /**
   * List of asset identifiers that were paused.
   */
  pausedAssetIds: string[];
}

export interface ResumeAllAssetsResponse {
  /**
   * List of asset identifiers that were resumed.
   */
  resumedAssetIds: string[];
}

/**
 * Asset
 */

export interface GetAssetsResponse {
  /**
   * List of asset identifiers.
   */
  assets: string[];
}

export interface PreloadAssetOptions {
  /**
   * Unique identifier for the asset.
   */
  assetId: string;
  /**
   * Source of the asset.
   * Can be a local file path or a remote URL.
   */
  source: string;
  /**
   * Volume of the asset.
   * Range is from `0.0` (silent) to `1.0` (full volume).
   *
   * @default 1.0
   */
  volume?: number;
  /**
   * Playback rate of the asset.
   * Range is from `0.5` (half speed) to `2.0` (double speed).
   *
   * @default 1.0
   */
  rate?: number;
  /**
   * Number of times the asset should loop.
   * `-1` means infinite looping.
   * `0` means no looping.
   * Positive integers indicate the number of loops.
   *
   * @default 0
   */
  numberOfLoops?: number;
  /**
   * Whether to enable position updates for the asset.
   * This allows the asset to send periodic updates about its current playback position.
   * If enabled, the asset will send position updates at the interval specified by `positionUpdateInterval`.
   * You can listen for these updates using the `NativeAudio.addListener('assetPositionUpdate', callback)` method.
   *
   * @default false
   */
  enablePositionUpdates?: boolean;
  /**
   * Interval in seconds for position updates.
   * Minimum value is `0.1`.
   * Maximum value is `2.0`.
   *
   * @default 0.5
   */
  positionUpdateInterval?: number;
}

export interface PreloadAssetResponse {
  /**
   * Unique identifier for the asset.
   */
  assetId: string;
  /**
   * Duration of the asset in seconds.
   */
  duration: number;
}

export interface UnloadAssetOptions {
  /**
   * Unique identifier for the asset to unload.
   */
  assetId: string;
}

export interface UnloadAssetResponse {
  /**
   * Unique identifier for the unloaded asset.
   */
  assetId: string;
}

export interface GetAssetStateOptions {
  /**
   * Unique identifier for the asset to get the state of.
   */
  assetId: string;
}

export interface GetAssetStateResponse {
  /**
   * Unique identifier for the asset.
   */
  assetId: string;
  /**
   * Whether the asset is currently playing.
   */
  isPlaying: boolean;
  /**
   * Current playback time of the asset in seconds.
   */
  currentTime: number;
  /**
   * Duration of the asset in seconds.
   */
  duration: number;
}

export interface PlayAssetOptions {
  /**
   * Unique identifier for the asset to play.
   */
  assetId: string;
}

export interface PlayAssetResponse {
  /**
   * Unique identifier for the asset that was played.
   */
  assetId: string;
  /**
   * Whether the asset is currently playing.
   */
  isPlaying: boolean;
}

export interface ResumeAssetOptions {
  /**
   * Unique identifier for the asset to resume.
   */
  assetId: string;
}

export interface ResumeAssetResponse {
  /**
   * Unique identifier for the asset that was resumed.
   */
  assetId: string;
  /**
   * Whether the asset is currently playing.
   */
  isPlaying: boolean;
}

export interface PauseAssetOptions {
  /**
   * Unique identifier for the asset to pause.
   */
  assetId: string;
}

export interface PauseAssetResponse {
  /**
   * Unique identifier for the asset that was paused.
   */
  assetId: string;
  /**
   * Whether the asset is currently playing.
   */
  isPlaying: boolean;
}

export interface StopAssetOptions {
  /**
   * Unique identifier for the asset to stop.
   */
  assetId: string;
}

export interface StopAssetResponse {
  /**
   * Unique identifier for the asset that was stopped.
   */
  assetId: string;
  /**
   * Whether the asset is currently playing.
   */
  isPlaying: boolean;
}

export interface SeekAssetOptions {
  /**
   * Unique identifier for the asset to seek.
   */
  assetId: string;
  /**
   * Time in seconds to seek to.
   */
  time: number;
}

export interface SeekAssetResponse {
  /**
   * Unique identifier for the asset that was seeked.
   */
  assetId: string;
  /**
   * Current playback time of the asset after seeking in seconds.
   */
  currentTime: number;
}

export interface SetAssetVolumeOptions {
  /**
   * Unique identifier for the asset to set the volume for.
   */
  assetId: string;
  /**
   * Volume level for the asset.
   * Range is from `0.0` (silent) to `1.0` (full volume).
   */
  volume: number;
}

export interface SetAssetVolumeResponse {
  /**
   * Unique identifier for the asset that had its volume set.
   */
  assetId: string;
  /**
   * Volume level that was set for the asset.
   */
  volume: number;
}

export interface SetAssetRateOptions {
  /**
   * Unique identifier for the asset to set the playback rate for.
   */
  assetId: string;
  /**
   * Playback rate for the asset.
   * Range is from `0.5` (half speed) to `2.0` (double speed).
   */
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

export interface SetAssetEnablePositionUpdatesOptions {
  assetId: string;
  enabled: boolean;
}

export interface SetAssetEnablePositionUpdatesResponse {
  assetId: string;
  enablePositionUpdates: boolean;
}

export interface SetAssetPositionUpdateIntervalOptions {
  assetId: string;
  positionUpdateInterval: number;
}

export interface SetAssetPositionUpdateIntervalResponse {
  assetId: string;
  positionUpdateInterval: number;
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
