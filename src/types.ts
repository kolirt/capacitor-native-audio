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
   * Automatically pause and resume all players when the audio session is interrupted or resumed.
   *
   * @default true
   */
  enableAutoInterruptionHandling?: boolean;
  /**
   * Automatically deactivate the IOS audio session when all players are paused or stopped.
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

export interface PauseAllForInterruptionResponse {
  /**
   * List of player identifiers that were paused.
   */
  ids: string[];
}

export interface ResumeAllAfterInterruptionResponse {
  /**
   * List of player identifiers that were resumed.
   */
  ids: string[];
}

export interface GetResponse {
  /**
   * List of player identifiers.
   */
  ids: string[];
}

export interface PreloadOptions {
  /**
   * Type of the player to preload.
   */
  type: 'asset' | 'mixer';
  /**
   * Unique identifier for the player.
   */
  id: string;
  /**
   * Source of the player to preload.
   * Can be a local file path or a remote URL.
   */
  source: string;
  /**
   * Volume of the player.
   * Range is from `0.0` (silent) to `1.0` (full volume).
   *
   * @default 1.0
   */
  volume?: number;
  /**
   * Playback rate of the player.
   * Range is from `0.5` (half speed) to `2.0` (double speed).
   *
   * @default 1.0
   */
  rate?: number;
  /**
   * Number of times the player should loop.
   * `-1` means infinite looping.
   * `0` means no looping.
   * Positive integers indicate the number of loops.
   *
   * @default 0
   */
  numberOfLoops?: number;
  /**
   * Whether to enable position updates for the player.
   * This allows the player to send periodic updates about its current playback position.
   * If enabled, the player will send position updates at the interval specified by `positionUpdateInterval`.
   * You can listen for these updates using the `NativeAudio.addListener('playerPositionUpdated', callback)` method.
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

export interface PreloadResponse {
  /**
   * Unique identifier for the player that was preloaded.
   */
  id: string;
  /**
   * Duration of the player in seconds.
   */
  duration: number;
}

export interface PreloadMixerBackgroundOptions {
  /**
   * Mixer identifier for the background player to preload.
   */
  mixerId: string;
  /**
   * Unique identifier for the background player to preload.
   */
  id: string;
  /**
   * Source of the player to preload.
   * Can be a local file path or a remote URL.
   */
  source: string;
  /**
   * Volume of the player.
   * Range is from `0.0` (silent) to `1.0` (full volume).
   *
   * @default 1.0
   */
  volume?: number;
  /**
   * Playback rate of the player.
   * Range is from `0.5` (half speed) to `2.0` (double speed).
   *
   * @default 1.0
   */
  rate?: number;
}

export interface PreloadMixerBackgroundResponse {
  /**
   * Unique identifier for the background player that was preloaded.
   */
  id: string;
  /**
   * Duration of the background player in seconds.
   */
  duration: number;
}

export interface UnloadOptions {
  /**
   * Unique identifier for the player to unload.
   */
  id: string;
}

export interface UnloadResponse {
  /**
   * Unique identifier for the unloaded player.
   */
  id: string;
}

export interface UnloadMixerBackgroundOptions {
  /**
   * Mixer identifier for the player to unload.
   */
  mixerId: string;
  /**
   * Identifier for the background player to unload.
   */
  id: string;
}

export interface UnloadMixerBackgroundResponse {
  /**
   * Identifier for the unloaded background player.
   */
  id: string;
}

export interface GetStateOptions {
  /**
   * Unique identifier for the player to get the state of.
   */
  id: string;
}

export interface GetStateResponse {
  /**
   * Type of the player.
   * Can be either 'asset' or 'mixer'.
   */
  type: 'asset' | 'mixer';
  /**
   * Unique identifier for the player.
   */
  id: string;
  /**
   * Whether the player is currently playing.
   */
  isPlaying: boolean;
  /**
   * Current playback time of the player in seconds.
   */
  currentTime: number;
  /**
   * Duration of the player in seconds.
   */
  duration: number;
  /**
   * Volume level of the player.
   */
  volume: number;
  /**
   * Playback rate of the player.
   * Range is from `0.5` (half speed) to `2.0` (double speed).
   */
  rate: number;
  /**
   * Number of loops for the player.
   * `-1` means infinite looping.
   * `0` means no looping.
   * Positive integers indicate the number of loops.
   */
  numberOfLoops: number;
}

export interface PlayOptions {
  /**
   * Unique identifier for the player to play.
   */
  id: string;
}

export interface PlayResponse {
  /**
   * Unique identifier for the player that was played.
   */
  id: string;
  /**
   * Whether the player is currently playing.
   */
  isPlaying: boolean;
}

export interface ResumeOptions {
  /**
   * Unique identifier for the player to resume.
   */
  id: string;
}

export interface ResumeResponse {
  /**
   * Unique identifier for the player that was resumed.
   */
  id: string;
  /**
   * Whether the player is currently playing.
   */
  isPlaying: boolean;
}

export interface PauseOptions {
  /**
   * Unique identifier for the player to pause.
   */
  id: string;
}

export interface PauseResponse {
  /**
   * Unique identifier for the player that was paused.
   */
  id: string;
  /**
   * Whether the player is currently playing.
   */
  isPlaying: boolean;
}

export interface StopOptions {
  /**
   * Unique identifier for the player to stop.
   */
  id: string;
}

export interface StopResponse {
  /**
   * Unique identifier for the player that was stopped.
   */
  id: string;
  /**
   * Whether the player is currently playing.
   */
  isPlaying: boolean;
}

export interface SeekOptions {
  /**
   * Unique identifier for the player to seek.
   */
  id: string;
  /**
   * Time in seconds to seek to.
   */
  time: number;
}

export interface SeekResponse {
  /**
   * Unique identifier for the player that was seeked.
   */
  id: string;
  /**
   * Current playback time of the player after seeking in seconds.
   */
  currentTime: number;
}

export interface SetVolumeOptions {
  /**
   * Unique identifier for the player to set the volume for.
   */
  id: string;
  /**
   * Volume level for the player.
   * Range is from `0.0` (silent) to `1.0` (full volume).
   */
  volume: number;
}

export interface SetVolumeResponse {
  /**
   * Unique identifier for the player that had its volume set.
   */
  id: string;
  /**
   * Volume level that was set for the player.
   */
  volume: number;
}

export interface SetRateOptions {
  /**
   * Unique identifier for the player to set the playback rate for.
   */
  id: string;
  /**
   * Playback rate for the player.
   * Range is from `0.5` (half speed) to `2.0` (double speed).
   */
  rate: number;
}

export interface SetRateResponse {
  /**
   * Unique identifier for the player that had its playback rate set.
   */
  id: string;
  /**
   * Playback rate that was set for the player.
   */
  rate: number;
}

export interface SetNumberOfLoopsOptions {
  /**
   * Unique identifier for the player to set the number of loops for.
   */
  id: string;
  /**
   * Number of loops for the player.
   * `-1` means infinite looping.
   * `0` means no looping.
   * Positive integers indicate the number of loops.
   */
  numberOfLoops: number;
}

export interface SetNumberOfLoopsResponse {
  /**
   * Unique identifier for the player that had its number of loops set.
   */
  id: string;
  /**
   * Number of loops that was set for the player.
   */
  numberOfLoops: number;
}

export interface SetEnablePositionUpdatesOptions {
  /**
   * Unique identifier for the player to enable or disable position updates for.
   */
  id: string;
  /**
   * Whether to enable position updates for the player.
   */
  enabled: boolean;
}

export interface SetEnablePositionUpdatesResponse {
  /**
   * Unique identifier for the player that had position updates enabled or disabled.
   */
  id: string;
  /**
   * Whether position updates are enabled for the player.
   */
  enablePositionUpdates: boolean;
}

export interface SetPositionUpdateIntervalOptions {
  /**
   * Unique identifier for the player to set the position update interval for.
   */
  id: string;
  /**
   * Interval in seconds for position updates.
   * Minimum value is `0.1`.
   * Maximum value is `2.0`.
   * Default is `0.5`.
   */
  positionUpdateInterval: number;
}

export interface SetPositionUpdateIntervalResponse {
  /**
   * Unique identifier for the player that had its position update interval set.
   */
  id: string;
  /**
   * Position update interval that was set for the player.
   */
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

export interface PlayerLoadedEvent {
  eventName: 'playerLoaded';
  id: string;
  duration: number;
}

export interface PlayerUnloadedEvent {
  eventName: 'playerUnloaded';
  id: string;
}

export interface PlayerStartedEvent {
  eventName: 'playerStarted';
  id: string;
}

export interface PlayerPausedEvent {
  eventName: 'playerPaused';
  id: string;
}

export interface PlayerStoppedEvent {
  eventName: 'playerStopped';
  id: string;
}

export interface PlayerSeekedEvent {
  eventName: 'playerSeeked';
  id: string;
  currentTime: number;
}

export interface PlayerCompletedEvent {
  eventName: 'playerCompleted';
  id: string;
}

export interface PlayerErrorEvent {
  eventName: 'playerError';
  id: string;
  error: string;
}

export interface PlayerPositionUpdatedEvent {
  eventName: 'playerPositionUpdated';
  id: string;
  currentTime: number;
}
