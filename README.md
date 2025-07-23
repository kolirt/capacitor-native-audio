# @kolirt/capacitor-native-audio

native audio plugin

## Install

```bash
npm install @kolirt/capacitor-native-audio
npx cap sync
```

## API

<docgen-index>

* [`configureSession(...)`](#configuresession)
* [`pauseAllForInterruption()`](#pauseallforinterruption)
* [`resumeAllAfterInterruption()`](#resumeallafterinterruption)
* [`getPlayers()`](#getplayers)
* [`preload(...)`](#preload)
* [`unload(...)`](#unload)
* [`getState(...)`](#getstate)
* [`play(...)`](#play)
* [`resume(...)`](#resume)
* [`pause(...)`](#pause)
* [`stop(...)`](#stop)
* [`seek(...)`](#seek)
* [`setVolume(...)`](#setvolume)
* [`setRate(...)`](#setrate)
* [`setNumberOfLoops(...)`](#setnumberofloops)
* [`setEnablePositionUpdates(...)`](#setenablepositionupdates)
* [`setPositionUpdateInterval(...)`](#setpositionupdateinterval)
* [`addListener('sessionInterrupted', ...)`](#addlistenersessioninterrupted-)
* [`addListener('sessionRouteChanged', ...)`](#addlistenersessionroutechanged-)
* [`addListener('playerLoaded', ...)`](#addlistenerplayerloaded-)
* [`addListener('playerUnloaded', ...)`](#addlistenerplayerunloaded-)
* [`addListener('playerStarted', ...)`](#addlistenerplayerstarted-)
* [`addListener('playerPaused', ...)`](#addlistenerplayerpaused-)
* [`addListener('playerStopped', ...)`](#addlistenerplayerstopped-)
* [`addListener('playerSeeked', ...)`](#addlistenerplayerseeked-)
* [`addListener('playerCompleted', ...)`](#addlistenerplayercompleted-)
* [`addListener('playerError', ...)`](#addlistenerplayererror-)
* [`addListener('playerPositionUpdated', ...)`](#addlistenerplayerpositionupdated-)
* [Interfaces](#interfaces)
* [Type Aliases](#type-aliases)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### configureSession(...)

```typescript
configureSession(options: ConfigureSessionOptions) => Promise<null>
```

| Param         | Type                                                                        |
| ------------- | --------------------------------------------------------------------------- |
| **`options`** | <code><a href="#configuresessionoptions">ConfigureSessionOptions</a></code> |

**Returns:** <code>Promise&lt;null&gt;</code>

--------------------


### pauseAllForInterruption()

```typescript
pauseAllForInterruption() => Promise<PauseAllForInterruptionResponse>
```

**Returns:** <code>Promise&lt;<a href="#pauseallforinterruptionresponse">PauseAllForInterruptionResponse</a>&gt;</code>

--------------------


### resumeAllAfterInterruption()

```typescript
resumeAllAfterInterruption() => Promise<ResumeAllAfterInterruptionResponse>
```

**Returns:** <code>Promise&lt;<a href="#resumeallafterinterruptionresponse">ResumeAllAfterInterruptionResponse</a>&gt;</code>

--------------------


### getPlayers()

```typescript
getPlayers() => Promise<GetResponse>
```

Player

**Returns:** <code>Promise&lt;<a href="#getresponse">GetResponse</a>&gt;</code>

--------------------


### preload(...)

```typescript
preload(options: PreloadOptions) => Promise<PreloadResponse>
```

| Param         | Type                                                      |
| ------------- | --------------------------------------------------------- |
| **`options`** | <code><a href="#preloadoptions">PreloadOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#preloadresponse">PreloadResponse</a>&gt;</code>

--------------------


### unload(...)

```typescript
unload(options: UnloadOptions) => Promise<UnloadResponse>
```

| Param         | Type                                                    |
| ------------- | ------------------------------------------------------- |
| **`options`** | <code><a href="#unloadoptions">UnloadOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#unloadresponse">UnloadResponse</a>&gt;</code>

--------------------


### getState(...)

```typescript
getState(options: GetStateOptions) => Promise<GetStateResponse>
```

| Param         | Type                                                        |
| ------------- | ----------------------------------------------------------- |
| **`options`** | <code><a href="#getstateoptions">GetStateOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#getstateresponse">GetStateResponse</a>&gt;</code>

--------------------


### play(...)

```typescript
play(options: PlayOptions) => Promise<PlayResponse>
```

| Param         | Type                                                |
| ------------- | --------------------------------------------------- |
| **`options`** | <code><a href="#playoptions">PlayOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#playresponse">PlayResponse</a>&gt;</code>

--------------------


### resume(...)

```typescript
resume(options: ResumeOptions) => Promise<ResumeResponse>
```

| Param         | Type                                                    |
| ------------- | ------------------------------------------------------- |
| **`options`** | <code><a href="#resumeoptions">ResumeOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#resumeresponse">ResumeResponse</a>&gt;</code>

--------------------


### pause(...)

```typescript
pause(options: PauseOptions) => Promise<PauseResponse>
```

| Param         | Type                                                  |
| ------------- | ----------------------------------------------------- |
| **`options`** | <code><a href="#pauseoptions">PauseOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#pauseresponse">PauseResponse</a>&gt;</code>

--------------------


### stop(...)

```typescript
stop(options: StopOptions) => Promise<StopResponse>
```

| Param         | Type                                                |
| ------------- | --------------------------------------------------- |
| **`options`** | <code><a href="#stopoptions">StopOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#stopresponse">StopResponse</a>&gt;</code>

--------------------


### seek(...)

```typescript
seek(options: SeekOptions) => Promise<SeekResponse>
```

| Param         | Type                                                |
| ------------- | --------------------------------------------------- |
| **`options`** | <code><a href="#seekoptions">SeekOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#seekresponse">SeekResponse</a>&gt;</code>

--------------------


### setVolume(...)

```typescript
setVolume(options: SetVolumeOptions) => Promise<SetVolumeResponse>
```

| Param         | Type                                                          |
| ------------- | ------------------------------------------------------------- |
| **`options`** | <code><a href="#setvolumeoptions">SetVolumeOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#setvolumeresponse">SetVolumeResponse</a>&gt;</code>

--------------------


### setRate(...)

```typescript
setRate(options: SetRateOptions) => Promise<SetRateResponse>
```

| Param         | Type                                                      |
| ------------- | --------------------------------------------------------- |
| **`options`** | <code><a href="#setrateoptions">SetRateOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#setrateresponse">SetRateResponse</a>&gt;</code>

--------------------


### setNumberOfLoops(...)

```typescript
setNumberOfLoops(options: SetNumberOfLoopsOptions) => Promise<SetNumberOfLoopsResponse>
```

| Param         | Type                                                                        |
| ------------- | --------------------------------------------------------------------------- |
| **`options`** | <code><a href="#setnumberofloopsoptions">SetNumberOfLoopsOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#setnumberofloopsresponse">SetNumberOfLoopsResponse</a>&gt;</code>

--------------------


### setEnablePositionUpdates(...)

```typescript
setEnablePositionUpdates(options: SetEnablePositionUpdatesOptions) => Promise<SetEnablePositionUpdatesResponse>
```

| Param         | Type                                                                                        |
| ------------- | ------------------------------------------------------------------------------------------- |
| **`options`** | <code><a href="#setenablepositionupdatesoptions">SetEnablePositionUpdatesOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#setenablepositionupdatesresponse">SetEnablePositionUpdatesResponse</a>&gt;</code>

--------------------


### setPositionUpdateInterval(...)

```typescript
setPositionUpdateInterval(options: SetPositionUpdateIntervalOptions) => Promise<SetPositionUpdateIntervalResponse>
```

| Param         | Type                                                                                          |
| ------------- | --------------------------------------------------------------------------------------------- |
| **`options`** | <code><a href="#setpositionupdateintervaloptions">SetPositionUpdateIntervalOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#setpositionupdateintervalresponse">SetPositionUpdateIntervalResponse</a>&gt;</code>

--------------------


### addListener('sessionInterrupted', ...)

```typescript
addListener(eventName: 'sessionInterrupted', listenerFunc: (data: SessionInterruptedEvent) => void) => Promise<PluginListenerHandle>
```

Event Listeners

| Param              | Type                                                                                           |
| ------------------ | ---------------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'sessionInterrupted'</code>                                                              |
| **`listenerFunc`** | <code>(data: <a href="#sessioninterruptedevent">SessionInterruptedEvent</a>) =&gt; void</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

--------------------


### addListener('sessionRouteChanged', ...)

```typescript
addListener(eventName: 'sessionRouteChanged', listenerFunc: (data: SessionRouteChangedEvent) => void) => Promise<PluginListenerHandle>
```

| Param              | Type                                                                                             |
| ------------------ | ------------------------------------------------------------------------------------------------ |
| **`eventName`**    | <code>'sessionRouteChanged'</code>                                                               |
| **`listenerFunc`** | <code>(data: <a href="#sessionroutechangedevent">SessionRouteChangedEvent</a>) =&gt; void</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

--------------------


### addListener('playerLoaded', ...)

```typescript
addListener(eventName: PlayerLoadedEvent['eventName'], listenerFunc: EventListener<PlayerLoadedEvent>) => Promise<PluginListenerHandle>
```

Add a listener for an event.

| Param              | Type                                                                                                              |
| ------------------ | ----------------------------------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'playerLoaded'</code>                                                                                       |
| **`listenerFunc`** | <code><a href="#eventlistener">EventListener</a>&lt;<a href="#playerloadedevent">PlayerLoadedEvent</a>&gt;</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

--------------------


### addListener('playerUnloaded', ...)

```typescript
addListener(eventName: PlayerUnloadedEvent['eventName'], listenerFunc: EventListener<PlayerUnloadedEvent>) => Promise<PluginListenerHandle>
```

| Param              | Type                                                                                                                  |
| ------------------ | --------------------------------------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'playerUnloaded'</code>                                                                                         |
| **`listenerFunc`** | <code><a href="#eventlistener">EventListener</a>&lt;<a href="#playerunloadedevent">PlayerUnloadedEvent</a>&gt;</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

--------------------


### addListener('playerStarted', ...)

```typescript
addListener(eventName: PlayerStartedEvent['eventName'], listenerFunc: EventListener<PlayerStartedEvent>) => Promise<PluginListenerHandle>
```

| Param              | Type                                                                                                                |
| ------------------ | ------------------------------------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'playerStarted'</code>                                                                                        |
| **`listenerFunc`** | <code><a href="#eventlistener">EventListener</a>&lt;<a href="#playerstartedevent">PlayerStartedEvent</a>&gt;</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

--------------------


### addListener('playerPaused', ...)

```typescript
addListener(eventName: PlayerPausedEvent['eventName'], listenerFunc: EventListener<PlayerPausedEvent>) => Promise<PluginListenerHandle>
```

| Param              | Type                                                                                                              |
| ------------------ | ----------------------------------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'playerPaused'</code>                                                                                       |
| **`listenerFunc`** | <code><a href="#eventlistener">EventListener</a>&lt;<a href="#playerpausedevent">PlayerPausedEvent</a>&gt;</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

--------------------


### addListener('playerStopped', ...)

```typescript
addListener(eventName: PlayerStoppedEvent['eventName'], listenerFunc: EventListener<PlayerStoppedEvent>) => Promise<PluginListenerHandle>
```

| Param              | Type                                                                                                                |
| ------------------ | ------------------------------------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'playerStopped'</code>                                                                                        |
| **`listenerFunc`** | <code><a href="#eventlistener">EventListener</a>&lt;<a href="#playerstoppedevent">PlayerStoppedEvent</a>&gt;</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

--------------------


### addListener('playerSeeked', ...)

```typescript
addListener(eventName: PlayerSeekedEvent['eventName'], listenerFunc: EventListener<PlayerSeekedEvent>) => Promise<PluginListenerHandle>
```

| Param              | Type                                                                                                              |
| ------------------ | ----------------------------------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'playerSeeked'</code>                                                                                       |
| **`listenerFunc`** | <code><a href="#eventlistener">EventListener</a>&lt;<a href="#playerseekedevent">PlayerSeekedEvent</a>&gt;</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

--------------------


### addListener('playerCompleted', ...)

```typescript
addListener(eventName: PlayerCompletedEvent['eventName'], listenerFunc: EventListener<PlayerCompletedEvent>) => Promise<PluginListenerHandle>
```

| Param              | Type                                                                                                                    |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'playerCompleted'</code>                                                                                          |
| **`listenerFunc`** | <code><a href="#eventlistener">EventListener</a>&lt;<a href="#playercompletedevent">PlayerCompletedEvent</a>&gt;</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

--------------------


### addListener('playerError', ...)

```typescript
addListener(eventName: PlayerErrorEvent['eventName'], listenerFunc: EventListener<PlayerErrorEvent>) => Promise<PluginListenerHandle>
```

| Param              | Type                                                                                                            |
| ------------------ | --------------------------------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'playerError'</code>                                                                                      |
| **`listenerFunc`** | <code><a href="#eventlistener">EventListener</a>&lt;<a href="#playererrorevent">PlayerErrorEvent</a>&gt;</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

--------------------


### addListener('playerPositionUpdated', ...)

```typescript
addListener(eventName: PlayerPositionUpdatedEvent['eventName'], listenerFunc: EventListener<PlayerPositionUpdatedEvent>) => Promise<PluginListenerHandle>
```

| Param              | Type                                                                                                                                |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'playerPositionUpdated'</code>                                                                                                |
| **`listenerFunc`** | <code><a href="#eventlistener">EventListener</a>&lt;<a href="#playerpositionupdatedevent">PlayerPositionUpdatedEvent</a>&gt;</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

--------------------


### Interfaces


#### ConfigureSessionOptions

| Prop                                   | Type                                                                      | Description                                                                                                                                        | Default           |
| -------------------------------------- | ------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------- |
| **`enableAutoInterruptionHandling`**   | <code>boolean</code>                                                      | Automatically pause and resume all assets when the audio session is interrupted or resumed.                                                        | <code>true</code> |
| **`enableAutoIosSessionDeactivation`** | <code>boolean</code>                                                      | Automatically deactivate the IOS audio session when all assets are paused or stopped.                                                              | <code>true</code> |
| **`iosCategory`**                      | <code><a href="#avaudiosessioncategory">AVAudioSessionCategory</a></code> | Unique identifier for the IOS audio session. [docs](https://developer.apple.com/documentation/avfaudio/avaudiosession/category-swift.struct)       |                   |
| **`iosMode`**                          | <code><a href="#avaudiosessionmode">AVAudioSessionMode</a></code>         | Unique identifier for the IOS audio session mode. [docs](https://developer.apple.com/documentation/avfaudio/avaudiosession/mode-swift.struct)      |                   |
| **`iosOptions`**                       | <code>AVAudioSessionCategoryOptions[]</code>                              | Options for the IOS audio session category. [docs](https://developer.apple.com/documentation/avfaudio/avaudiosession/categoryoptions-swift.struct) |                   |


#### PauseAllForInterruptionResponse

| Prop      | Type                  | Description                                  |
| --------- | --------------------- | -------------------------------------------- |
| **`ids`** | <code>string[]</code> | List of player identifiers that were paused. |


#### ResumeAllAfterInterruptionResponse

| Prop      | Type                  | Description                                   |
| --------- | --------------------- | --------------------------------------------- |
| **`ids`** | <code>string[]</code> | List of player identifiers that were resumed. |


#### GetResponse

| Prop      | Type                  | Description                 |
| --------- | --------------------- | --------------------------- |
| **`ids`** | <code>string[]</code> | List of player identifiers. |


#### PreloadResponse

| Prop           | Type                | Description                       |
| -------------- | ------------------- | --------------------------------- |
| **`id`**       | <code>string</code> | Unique identifier for the asset.  |
| **`duration`** | <code>number</code> | Duration of the asset in seconds. |


#### PreloadOptions

| Prop                         | Type                            | Description                                                                                                                                                                                                                                                                                                                                                      | Default            |
| ---------------------------- | ------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------ |
| **`type`**                   | <code>'asset' \| 'mixer'</code> | Type of the player to preload.                                                                                                                                                                                                                                                                                                                                   |                    |
| **`id`**                     | <code>string</code>             | Unique identifier for the player.                                                                                                                                                                                                                                                                                                                                |                    |
| **`source`**                 | <code>string</code>             | Source of the player to preload. Can be a local file path or a remote URL.                                                                                                                                                                                                                                                                                       |                    |
| **`volume`**                 | <code>number</code>             | Volume of the player. Range is from `0.0` (silent) to `1.0` (full volume).                                                                                                                                                                                                                                                                                       | <code>1.0</code>   |
| **`rate`**                   | <code>number</code>             | Playback rate of the player. Range is from `0.5` (half speed) to `2.0` (double speed).                                                                                                                                                                                                                                                                           | <code>1.0</code>   |
| **`numberOfLoops`**          | <code>number</code>             | Number of times the player should loop. `-1` means infinite looping. `0` means no looping. Positive integers indicate the number of loops.                                                                                                                                                                                                                       | <code>0</code>     |
| **`enablePositionUpdates`**  | <code>boolean</code>            | Whether to enable position updates for the player. This allows the player to send periodic updates about its current playback position. If enabled, the player will send position updates at the interval specified by `positionUpdateInterval`. You can listen for these updates using the `NativeAudio.addListener('playerPositionUpdated', callback)` method. | <code>false</code> |
| **`positionUpdateInterval`** | <code>number</code>             | Interval in seconds for position updates. Minimum value is `0.1`. Maximum value is `2.0`.                                                                                                                                                                                                                                                                        | <code>0.5</code>   |


#### UnloadResponse

| Prop     | Type                | Description                                |
| -------- | ------------------- | ------------------------------------------ |
| **`id`** | <code>string</code> | Unique identifier for the unloaded player. |


#### UnloadOptions

| Prop     | Type                | Description                                 |
| -------- | ------------------- | ------------------------------------------- |
| **`id`** | <code>string</code> | Unique identifier for the player to unload. |


#### GetStateResponse

| Prop                | Type                            | Description                                                                                                                        |
| ------------------- | ------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| **`type`**          | <code>'asset' \| 'mixer'</code> | Type of the player. Can be either 'asset' or 'mixer'.                                                                              |
| **`id`**            | <code>string</code>             | Unique identifier for the player.                                                                                                  |
| **`isPlaying`**     | <code>boolean</code>            | Whether the player is currently playing.                                                                                           |
| **`currentTime`**   | <code>number</code>             | Current playback time of the player in seconds.                                                                                    |
| **`duration`**      | <code>number</code>             | Duration of the player in seconds.                                                                                                 |
| **`volume`**        | <code>number</code>             | Volume level of the player.                                                                                                        |
| **`rate`**          | <code>number</code>             | Playback rate of the player. Range is from `0.5` (half speed) to `2.0` (double speed).                                             |
| **`numberOfLoops`** | <code>number</code>             | Number of loops for the player. `-1` means infinite looping. `0` means no looping. Positive integers indicate the number of loops. |


#### GetStateOptions

| Prop     | Type                | Description                                           |
| -------- | ------------------- | ----------------------------------------------------- |
| **`id`** | <code>string</code> | Unique identifier for the player to get the state of. |


#### PlayResponse

| Prop            | Type                 | Description                                       |
| --------------- | -------------------- | ------------------------------------------------- |
| **`id`**        | <code>string</code>  | Unique identifier for the player that was played. |
| **`isPlaying`** | <code>boolean</code> | Whether the player is currently playing.          |


#### PlayOptions

| Prop     | Type                | Description                               |
| -------- | ------------------- | ----------------------------------------- |
| **`id`** | <code>string</code> | Unique identifier for the player to play. |


#### ResumeResponse

| Prop            | Type                 | Description                                        |
| --------------- | -------------------- | -------------------------------------------------- |
| **`id`**        | <code>string</code>  | Unique identifier for the player that was resumed. |
| **`isPlaying`** | <code>boolean</code> | Whether the player is currently playing.           |


#### ResumeOptions

| Prop     | Type                | Description                                 |
| -------- | ------------------- | ------------------------------------------- |
| **`id`** | <code>string</code> | Unique identifier for the player to resume. |


#### PauseResponse

| Prop            | Type                 | Description                                       |
| --------------- | -------------------- | ------------------------------------------------- |
| **`id`**        | <code>string</code>  | Unique identifier for the player that was paused. |
| **`isPlaying`** | <code>boolean</code> | Whether the player is currently playing.          |


#### PauseOptions

| Prop     | Type                | Description                                |
| -------- | ------------------- | ------------------------------------------ |
| **`id`** | <code>string</code> | Unique identifier for the player to pause. |


#### StopResponse

| Prop            | Type                 | Description                                        |
| --------------- | -------------------- | -------------------------------------------------- |
| **`id`**        | <code>string</code>  | Unique identifier for the player that was stopped. |
| **`isPlaying`** | <code>boolean</code> | Whether the player is currently playing.           |


#### StopOptions

| Prop     | Type                | Description                               |
| -------- | ------------------- | ----------------------------------------- |
| **`id`** | <code>string</code> | Unique identifier for the player to stop. |


#### SeekResponse

| Prop              | Type                | Description                                                   |
| ----------------- | ------------------- | ------------------------------------------------------------- |
| **`id`**          | <code>string</code> | Unique identifier for the player that was seeked.             |
| **`currentTime`** | <code>number</code> | Current playback time of the player after seeking in seconds. |


#### SeekOptions

| Prop       | Type                | Description                               |
| ---------- | ------------------- | ----------------------------------------- |
| **`id`**   | <code>string</code> | Unique identifier for the player to seek. |
| **`time`** | <code>number</code> | Time in seconds to seek to.               |


#### SetVolumeResponse

| Prop         | Type                | Description                                               |
| ------------ | ------------------- | --------------------------------------------------------- |
| **`id`**     | <code>string</code> | Unique identifier for the player that had its volume set. |
| **`volume`** | <code>number</code> | Volume level that was set for the player.                 |


#### SetVolumeOptions

| Prop         | Type                | Description                                                                       |
| ------------ | ------------------- | --------------------------------------------------------------------------------- |
| **`id`**     | <code>string</code> | Unique identifier for the player to set the volume for.                           |
| **`volume`** | <code>number</code> | Volume level for the player. Range is from `0.0` (silent) to `1.0` (full volume). |


#### SetRateResponse

| Prop       | Type                | Description                                                      |
| ---------- | ------------------- | ---------------------------------------------------------------- |
| **`id`**   | <code>string</code> | Unique identifier for the player that had its playback rate set. |
| **`rate`** | <code>number</code> | Playback rate that was set for the player.                       |


#### SetRateOptions

| Prop       | Type                | Description                                                                             |
| ---------- | ------------------- | --------------------------------------------------------------------------------------- |
| **`id`**   | <code>string</code> | Unique identifier for the player to set the playback rate for.                          |
| **`rate`** | <code>number</code> | Playback rate for the player. Range is from `0.5` (half speed) to `2.0` (double speed). |


#### SetNumberOfLoopsResponse

| Prop                | Type                | Description                                                        |
| ------------------- | ------------------- | ------------------------------------------------------------------ |
| **`id`**            | <code>string</code> | Unique identifier for the player that had its number of loops set. |
| **`numberOfLoops`** | <code>number</code> | Number of loops that was set for the player.                       |


#### SetNumberOfLoopsOptions

| Prop                | Type                | Description                                                                                                                        |
| ------------------- | ------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| **`id`**            | <code>string</code> | Unique identifier for the player to set the number of loops for.                                                                   |
| **`numberOfLoops`** | <code>number</code> | Number of loops for the player. `-1` means infinite looping. `0` means no looping. Positive integers indicate the number of loops. |


#### SetEnablePositionUpdatesResponse

| Prop                        | Type                 | Description                                                                     |
| --------------------------- | -------------------- | ------------------------------------------------------------------------------- |
| **`id`**                    | <code>string</code>  | Unique identifier for the player that had position updates enabled or disabled. |
| **`enablePositionUpdates`** | <code>boolean</code> | Whether position updates are enabled for the player.                            |


#### SetEnablePositionUpdatesOptions

| Prop          | Type                 | Description                                                                 |
| ------------- | -------------------- | --------------------------------------------------------------------------- |
| **`id`**      | <code>string</code>  | Unique identifier for the player to enable or disable position updates for. |
| **`enabled`** | <code>boolean</code> | Whether to enable position updates for the player.                          |


#### SetPositionUpdateIntervalResponse

| Prop                         | Type                | Description                                                                 |
| ---------------------------- | ------------------- | --------------------------------------------------------------------------- |
| **`id`**                     | <code>string</code> | Unique identifier for the player that had its position update interval set. |
| **`positionUpdateInterval`** | <code>number</code> | Position update interval that was set for the player.                       |


#### SetPositionUpdateIntervalOptions

| Prop                         | Type                | Description                                                                                                 |
| ---------------------------- | ------------------- | ----------------------------------------------------------------------------------------------------------- |
| **`id`**                     | <code>string</code> | Unique identifier for the player to set the position update interval for.                                   |
| **`positionUpdateInterval`** | <code>number</code> | Interval in seconds for position updates. Minimum value is `0.1`. Maximum value is `2.0`. Default is `0.5`. |


#### PluginListenerHandle

| Prop         | Type                                      |
| ------------ | ----------------------------------------- |
| **`remove`** | <code>() =&gt; Promise&lt;void&gt;</code> |


#### SessionInterruptedEvent

| Prop            | Type                              |
| --------------- | --------------------------------- |
| **`eventName`** | <code>'sessionInterrupted'</code> |
| **`state`**     | <code>'began' \| 'ended'</code>   |


#### SessionRouteChangedEvent

| Prop            | Type                               |
| --------------- | ---------------------------------- |
| **`eventName`** | <code>'sessionRouteChanged'</code> |
| **`reason`**    | <code>number</code>                |


#### PlayerLoadedEvent

| Prop            | Type                        |
| --------------- | --------------------------- |
| **`eventName`** | <code>'playerLoaded'</code> |
| **`id`**        | <code>string</code>         |
| **`duration`**  | <code>number</code>         |


#### PlayerUnloadedEvent

| Prop            | Type                          |
| --------------- | ----------------------------- |
| **`eventName`** | <code>'playerUnloaded'</code> |
| **`id`**        | <code>string</code>           |


#### PlayerStartedEvent

| Prop            | Type                         |
| --------------- | ---------------------------- |
| **`eventName`** | <code>'playerStarted'</code> |
| **`id`**        | <code>string</code>          |


#### PlayerPausedEvent

| Prop            | Type                        |
| --------------- | --------------------------- |
| **`eventName`** | <code>'playerPaused'</code> |
| **`id`**        | <code>string</code>         |


#### PlayerStoppedEvent

| Prop            | Type                         |
| --------------- | ---------------------------- |
| **`eventName`** | <code>'playerStopped'</code> |
| **`id`**        | <code>string</code>          |


#### PlayerSeekedEvent

| Prop              | Type                        |
| ----------------- | --------------------------- |
| **`eventName`**   | <code>'playerSeeked'</code> |
| **`id`**          | <code>string</code>         |
| **`currentTime`** | <code>number</code>         |


#### PlayerCompletedEvent

| Prop            | Type                           |
| --------------- | ------------------------------ |
| **`eventName`** | <code>'playerCompleted'</code> |
| **`id`**        | <code>string</code>            |


#### PlayerErrorEvent

| Prop            | Type                       |
| --------------- | -------------------------- |
| **`eventName`** | <code>'playerError'</code> |
| **`id`**        | <code>string</code>        |
| **`error`**     | <code>string</code>        |


#### PlayerPositionUpdatedEvent

| Prop              | Type                                 |
| ----------------- | ------------------------------------ |
| **`eventName`**   | <code>'playerPositionUpdated'</code> |
| **`id`**          | <code>string</code>                  |
| **`currentTime`** | <code>number</code>                  |


### Type Aliases


#### AVAudioSessionCategory

<code>'ambient' | 'multiRoute' | 'playAndRecord' | 'playback' | 'record' | 'soloAmbient'</code>


#### AVAudioSessionMode

<code>'default' | 'gameChat' | 'measurement' | 'moviePlayback' | 'spokenAudio' | 'videoChat' | 'videoRecording' | 'voiceChat' | 'voicePrompt'</code>


#### AVAudioSessionCategoryOptions

<code>'mixWithOthers' | 'duckOthers' | 'interruptSpokenAudioAndMixWithOthers' | 'allowBluetoothA2DP' | 'allowAirPlay' | 'defaultToSpeaker' | 'overrideMutedMicrophoneInterruption'</code>


#### EventListener

<code>(data: T): void</code>

</docgen-api>
