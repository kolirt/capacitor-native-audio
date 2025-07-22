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
* [`getAssets()`](#getassets)
* [`preloadAsset(...)`](#preloadasset)
* [`unloadAsset(...)`](#unloadasset)
* [`getAssetState(...)`](#getassetstate)
* [`playAsset(...)`](#playasset)
* [`resumeAsset(...)`](#resumeasset)
* [`pauseAsset(...)`](#pauseasset)
* [`stopAsset(...)`](#stopasset)
* [`seekAsset(...)`](#seekasset)
* [`setAssetVolume(...)`](#setassetvolume)
* [`setAssetRate(...)`](#setassetrate)
* [`setAssetNumberOfLoops(...)`](#setassetnumberofloops)
* [`setAssetEnablePositionUpdates(...)`](#setassetenablepositionupdates)
* [`setAssetPositionUpdateInterval(...)`](#setassetpositionupdateinterval)
* [`addListener('sessionInterrupted', ...)`](#addlistenersessioninterrupted-)
* [`addListener('sessionRouteChanged', ...)`](#addlistenersessionroutechanged-)
* [`addListener('assetLoaded', ...)`](#addlistenerassetloaded-)
* [`addListener('assetUnloaded', ...)`](#addlistenerassetunloaded-)
* [`addListener('assetStarted', ...)`](#addlistenerassetstarted-)
* [`addListener('assetPaused', ...)`](#addlistenerassetpaused-)
* [`addListener('assetStopped', ...)`](#addlistenerassetstopped-)
* [`addListener('assetSeeked', ...)`](#addlistenerassetseeked-)
* [`addListener('assetCompleted', ...)`](#addlistenerassetcompleted-)
* [`addListener('assetError', ...)`](#addlistenerasseterror-)
* [`addListener('assetPositionUpdate', ...)`](#addlistenerassetpositionupdate-)
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


### getAssets()

```typescript
getAssets() => Promise<GetAssetsResponse>
```

Asset

**Returns:** <code>Promise&lt;<a href="#getassetsresponse">GetAssetsResponse</a>&gt;</code>

--------------------


### preloadAsset(...)

```typescript
preloadAsset(options: PreloadAssetOptions) => Promise<PreloadAssetResponse>
```

| Param         | Type                                                                |
| ------------- | ------------------------------------------------------------------- |
| **`options`** | <code><a href="#preloadassetoptions">PreloadAssetOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#preloadassetresponse">PreloadAssetResponse</a>&gt;</code>

--------------------


### unloadAsset(...)

```typescript
unloadAsset(options: UnloadAssetOptions) => Promise<UnloadAssetResponse>
```

| Param         | Type                                                              |
| ------------- | ----------------------------------------------------------------- |
| **`options`** | <code><a href="#unloadassetoptions">UnloadAssetOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#unloadassetresponse">UnloadAssetResponse</a>&gt;</code>

--------------------


### getAssetState(...)

```typescript
getAssetState(options: GetAssetStateOptions) => Promise<GetAssetStateResponse>
```

| Param         | Type                                                                  |
| ------------- | --------------------------------------------------------------------- |
| **`options`** | <code><a href="#getassetstateoptions">GetAssetStateOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#getassetstateresponse">GetAssetStateResponse</a>&gt;</code>

--------------------


### playAsset(...)

```typescript
playAsset(options: PlayAssetOptions) => Promise<PlayAssetResponse>
```

| Param         | Type                                                          |
| ------------- | ------------------------------------------------------------- |
| **`options`** | <code><a href="#playassetoptions">PlayAssetOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#playassetresponse">PlayAssetResponse</a>&gt;</code>

--------------------


### resumeAsset(...)

```typescript
resumeAsset(options: ResumeAssetOptions) => Promise<ResumeAssetResponse>
```

| Param         | Type                                                              |
| ------------- | ----------------------------------------------------------------- |
| **`options`** | <code><a href="#resumeassetoptions">ResumeAssetOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#resumeassetresponse">ResumeAssetResponse</a>&gt;</code>

--------------------


### pauseAsset(...)

```typescript
pauseAsset(options: PauseAssetOptions) => Promise<PauseAssetResponse>
```

| Param         | Type                                                            |
| ------------- | --------------------------------------------------------------- |
| **`options`** | <code><a href="#pauseassetoptions">PauseAssetOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#pauseassetresponse">PauseAssetResponse</a>&gt;</code>

--------------------


### stopAsset(...)

```typescript
stopAsset(options: StopAssetOptions) => Promise<StopAssetResponse>
```

| Param         | Type                                                          |
| ------------- | ------------------------------------------------------------- |
| **`options`** | <code><a href="#stopassetoptions">StopAssetOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#stopassetresponse">StopAssetResponse</a>&gt;</code>

--------------------


### seekAsset(...)

```typescript
seekAsset(options: SeekAssetOptions) => Promise<SeekAssetResponse>
```

| Param         | Type                                                          |
| ------------- | ------------------------------------------------------------- |
| **`options`** | <code><a href="#seekassetoptions">SeekAssetOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#seekassetresponse">SeekAssetResponse</a>&gt;</code>

--------------------


### setAssetVolume(...)

```typescript
setAssetVolume(options: SetAssetVolumeOptions) => Promise<SetAssetVolumeResponse>
```

| Param         | Type                                                                    |
| ------------- | ----------------------------------------------------------------------- |
| **`options`** | <code><a href="#setassetvolumeoptions">SetAssetVolumeOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#setassetvolumeresponse">SetAssetVolumeResponse</a>&gt;</code>

--------------------


### setAssetRate(...)

```typescript
setAssetRate(options: SetAssetRateOptions) => Promise<SetAssetRateResponse>
```

| Param         | Type                                                                |
| ------------- | ------------------------------------------------------------------- |
| **`options`** | <code><a href="#setassetrateoptions">SetAssetRateOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#setassetrateresponse">SetAssetRateResponse</a>&gt;</code>

--------------------


### setAssetNumberOfLoops(...)

```typescript
setAssetNumberOfLoops(options: SetAssetNumberOfLoopsOptions) => Promise<SetAssetNumberOfLoopsResponse>
```

| Param         | Type                                                                                  |
| ------------- | ------------------------------------------------------------------------------------- |
| **`options`** | <code><a href="#setassetnumberofloopsoptions">SetAssetNumberOfLoopsOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#setassetnumberofloopsresponse">SetAssetNumberOfLoopsResponse</a>&gt;</code>

--------------------


### setAssetEnablePositionUpdates(...)

```typescript
setAssetEnablePositionUpdates(options: SetAssetEnablePositionUpdatesOptions) => Promise<SetAssetEnablePositionUpdatesResponse>
```

| Param         | Type                                                                                                  |
| ------------- | ----------------------------------------------------------------------------------------------------- |
| **`options`** | <code><a href="#setassetenablepositionupdatesoptions">SetAssetEnablePositionUpdatesOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#setassetenablepositionupdatesresponse">SetAssetEnablePositionUpdatesResponse</a>&gt;</code>

--------------------


### setAssetPositionUpdateInterval(...)

```typescript
setAssetPositionUpdateInterval(options: SetAssetPositionUpdateIntervalOptions) => Promise<SetAssetPositionUpdateIntervalResponse>
```

| Param         | Type                                                                                                    |
| ------------- | ------------------------------------------------------------------------------------------------------- |
| **`options`** | <code><a href="#setassetpositionupdateintervaloptions">SetAssetPositionUpdateIntervalOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#setassetpositionupdateintervalresponse">SetAssetPositionUpdateIntervalResponse</a>&gt;</code>

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


### addListener('assetLoaded', ...)

```typescript
addListener(eventName: AssetLoadedEvent['eventName'], listenerFunc: EventListener<AssetLoadedEvent>) => Promise<PluginListenerHandle>
```

Add a listener for an event.

| Param              | Type                                                                                                            |
| ------------------ | --------------------------------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'assetLoaded'</code>                                                                                      |
| **`listenerFunc`** | <code><a href="#eventlistener">EventListener</a>&lt;<a href="#assetloadedevent">AssetLoadedEvent</a>&gt;</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

--------------------


### addListener('assetUnloaded', ...)

```typescript
addListener(eventName: AssetUnloadedEvent['eventName'], listenerFunc: EventListener<AssetUnloadedEvent>) => Promise<PluginListenerHandle>
```

| Param              | Type                                                                                                                |
| ------------------ | ------------------------------------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'assetUnloaded'</code>                                                                                        |
| **`listenerFunc`** | <code><a href="#eventlistener">EventListener</a>&lt;<a href="#assetunloadedevent">AssetUnloadedEvent</a>&gt;</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

--------------------


### addListener('assetStarted', ...)

```typescript
addListener(eventName: AssetStartedEvent['eventName'], listenerFunc: EventListener<AssetStartedEvent>) => Promise<PluginListenerHandle>
```

| Param              | Type                                                                                                              |
| ------------------ | ----------------------------------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'assetStarted'</code>                                                                                       |
| **`listenerFunc`** | <code><a href="#eventlistener">EventListener</a>&lt;<a href="#assetstartedevent">AssetStartedEvent</a>&gt;</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

--------------------


### addListener('assetPaused', ...)

```typescript
addListener(eventName: AssetPausedEvent['eventName'], listenerFunc: EventListener<AssetPausedEvent>) => Promise<PluginListenerHandle>
```

| Param              | Type                                                                                                            |
| ------------------ | --------------------------------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'assetPaused'</code>                                                                                      |
| **`listenerFunc`** | <code><a href="#eventlistener">EventListener</a>&lt;<a href="#assetpausedevent">AssetPausedEvent</a>&gt;</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

--------------------


### addListener('assetStopped', ...)

```typescript
addListener(eventName: AssetStoppedEvent['eventName'], listenerFunc: EventListener<AssetStoppedEvent>) => Promise<PluginListenerHandle>
```

| Param              | Type                                                                                                              |
| ------------------ | ----------------------------------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'assetStopped'</code>                                                                                       |
| **`listenerFunc`** | <code><a href="#eventlistener">EventListener</a>&lt;<a href="#assetstoppedevent">AssetStoppedEvent</a>&gt;</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

--------------------


### addListener('assetSeeked', ...)

```typescript
addListener(eventName: AssetSeekedEvent['eventName'], listenerFunc: EventListener<AssetSeekedEvent>) => Promise<PluginListenerHandle>
```

| Param              | Type                                                                                                            |
| ------------------ | --------------------------------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'assetSeeked'</code>                                                                                      |
| **`listenerFunc`** | <code><a href="#eventlistener">EventListener</a>&lt;<a href="#assetseekedevent">AssetSeekedEvent</a>&gt;</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

--------------------


### addListener('assetCompleted', ...)

```typescript
addListener(eventName: AssetCompletedEvent['eventName'], listenerFunc: EventListener<AssetCompletedEvent>) => Promise<PluginListenerHandle>
```

| Param              | Type                                                                                                                  |
| ------------------ | --------------------------------------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'assetCompleted'</code>                                                                                         |
| **`listenerFunc`** | <code><a href="#eventlistener">EventListener</a>&lt;<a href="#assetcompletedevent">AssetCompletedEvent</a>&gt;</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

--------------------


### addListener('assetError', ...)

```typescript
addListener(eventName: AssetErrorEvent['eventName'], listenerFunc: EventListener<AssetErrorEvent>) => Promise<PluginListenerHandle>
```

| Param              | Type                                                                                                          |
| ------------------ | ------------------------------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'assetError'</code>                                                                                     |
| **`listenerFunc`** | <code><a href="#eventlistener">EventListener</a>&lt;<a href="#asseterrorevent">AssetErrorEvent</a>&gt;</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

--------------------


### addListener('assetPositionUpdate', ...)

```typescript
addListener(eventName: AssetPositionUpdateEvent['eventName'], listenerFunc: EventListener<AssetPositionUpdateEvent>) => Promise<PluginListenerHandle>
```

| Param              | Type                                                                                                                            |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'assetPositionUpdate'</code>                                                                                              |
| **`listenerFunc`** | <code><a href="#eventlistener">EventListener</a>&lt;<a href="#assetpositionupdateevent">AssetPositionUpdateEvent</a>&gt;</code> |

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

| Prop           | Type                  | Description                                 |
| -------------- | --------------------- | ------------------------------------------- |
| **`assetIds`** | <code>string[]</code> | List of asset identifiers that were paused. |


#### ResumeAllAfterInterruptionResponse

| Prop           | Type                  | Description                                  |
| -------------- | --------------------- | -------------------------------------------- |
| **`assetIds`** | <code>string[]</code> | List of asset identifiers that were resumed. |


#### GetAssetsResponse

Asset

| Prop         | Type                  | Description                |
| ------------ | --------------------- | -------------------------- |
| **`assets`** | <code>string[]</code> | List of asset identifiers. |


#### PreloadAssetResponse

| Prop           | Type                | Description                       |
| -------------- | ------------------- | --------------------------------- |
| **`id`**       | <code>string</code> | Unique identifier for the asset.  |
| **`duration`** | <code>number</code> | Duration of the asset in seconds. |


#### PreloadAssetOptions

| Prop                         | Type                 | Description                                                                                                                                                                                                                                                                                                                                                 | Default            |
| ---------------------------- | -------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------ |
| **`id`**                     | <code>string</code>  | Unique identifier for the asset.                                                                                                                                                                                                                                                                                                                            |                    |
| **`source`**                 | <code>string</code>  | Source of the asset. Can be a local file path or a remote URL.                                                                                                                                                                                                                                                                                              |                    |
| **`volume`**                 | <code>number</code>  | Volume of the asset. Range is from `0.0` (silent) to `1.0` (full volume).                                                                                                                                                                                                                                                                                   | <code>1.0</code>   |
| **`rate`**                   | <code>number</code>  | Playback rate of the asset. Range is from `0.5` (half speed) to `2.0` (double speed).                                                                                                                                                                                                                                                                       | <code>1.0</code>   |
| **`numberOfLoops`**          | <code>number</code>  | Number of times the asset should loop. `-1` means infinite looping. `0` means no looping. Positive integers indicate the number of loops.                                                                                                                                                                                                                   | <code>0</code>     |
| **`enablePositionUpdates`**  | <code>boolean</code> | Whether to enable position updates for the asset. This allows the asset to send periodic updates about its current playback position. If enabled, the asset will send position updates at the interval specified by `positionUpdateInterval`. You can listen for these updates using the `NativeAudio.addListener('assetPositionUpdate', callback)` method. | <code>false</code> |
| **`positionUpdateInterval`** | <code>number</code>  | Interval in seconds for position updates. Minimum value is `0.1`. Maximum value is `2.0`.                                                                                                                                                                                                                                                                   | <code>0.5</code>   |


#### UnloadAssetResponse

| Prop     | Type                | Description                               |
| -------- | ------------------- | ----------------------------------------- |
| **`id`** | <code>string</code> | Unique identifier for the unloaded asset. |


#### UnloadAssetOptions

| Prop     | Type                | Description                                |
| -------- | ------------------- | ------------------------------------------ |
| **`id`** | <code>string</code> | Unique identifier for the asset to unload. |


#### GetAssetStateResponse

| Prop                | Type                 | Description                                                                                                                       |
| ------------------- | -------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **`id`**            | <code>string</code>  | Unique identifier for the asset.                                                                                                  |
| **`isPlaying`**     | <code>boolean</code> | Whether the asset is currently playing.                                                                                           |
| **`currentTime`**   | <code>number</code>  | Current playback time of the asset in seconds.                                                                                    |
| **`duration`**      | <code>number</code>  | Duration of the asset in seconds.                                                                                                 |
| **`volume`**        | <code>number</code>  | Volume level of the asset.                                                                                                        |
| **`rate`**          | <code>number</code>  | Playback rate of the asset. Range is from `0.5` (half speed) to `2.0` (double speed).                                             |
| **`numberOfLoops`** | <code>number</code>  | Number of loops for the asset. `-1` means infinite looping. `0` means no looping. Positive integers indicate the number of loops. |


#### GetAssetStateOptions

| Prop     | Type                | Description                                          |
| -------- | ------------------- | ---------------------------------------------------- |
| **`id`** | <code>string</code> | Unique identifier for the asset to get the state of. |


#### PlayAssetResponse

| Prop            | Type                 | Description                                      |
| --------------- | -------------------- | ------------------------------------------------ |
| **`id`**        | <code>string</code>  | Unique identifier for the asset that was played. |
| **`isPlaying`** | <code>boolean</code> | Whether the asset is currently playing.          |


#### PlayAssetOptions

| Prop     | Type                | Description                              |
| -------- | ------------------- | ---------------------------------------- |
| **`id`** | <code>string</code> | Unique identifier for the asset to play. |


#### ResumeAssetResponse

| Prop            | Type                 | Description                                       |
| --------------- | -------------------- | ------------------------------------------------- |
| **`id`**        | <code>string</code>  | Unique identifier for the asset that was resumed. |
| **`isPlaying`** | <code>boolean</code> | Whether the asset is currently playing.           |


#### ResumeAssetOptions

| Prop     | Type                | Description                                |
| -------- | ------------------- | ------------------------------------------ |
| **`id`** | <code>string</code> | Unique identifier for the asset to resume. |


#### PauseAssetResponse

| Prop            | Type                 | Description                                      |
| --------------- | -------------------- | ------------------------------------------------ |
| **`id`**        | <code>string</code>  | Unique identifier for the asset that was paused. |
| **`isPlaying`** | <code>boolean</code> | Whether the asset is currently playing.          |


#### PauseAssetOptions

| Prop     | Type                | Description                               |
| -------- | ------------------- | ----------------------------------------- |
| **`id`** | <code>string</code> | Unique identifier for the asset to pause. |


#### StopAssetResponse

| Prop            | Type                 | Description                                       |
| --------------- | -------------------- | ------------------------------------------------- |
| **`id`**        | <code>string</code>  | Unique identifier for the asset that was stopped. |
| **`isPlaying`** | <code>boolean</code> | Whether the asset is currently playing.           |


#### StopAssetOptions

| Prop     | Type                | Description                              |
| -------- | ------------------- | ---------------------------------------- |
| **`id`** | <code>string</code> | Unique identifier for the asset to stop. |


#### SeekAssetResponse

| Prop              | Type                | Description                                                  |
| ----------------- | ------------------- | ------------------------------------------------------------ |
| **`id`**          | <code>string</code> | Unique identifier for the asset that was seeked.             |
| **`currentTime`** | <code>number</code> | Current playback time of the asset after seeking in seconds. |


#### SeekAssetOptions

| Prop       | Type                | Description                              |
| ---------- | ------------------- | ---------------------------------------- |
| **`id`**   | <code>string</code> | Unique identifier for the asset to seek. |
| **`time`** | <code>number</code> | Time in seconds to seek to.              |


#### SetAssetVolumeResponse

| Prop         | Type                | Description                                              |
| ------------ | ------------------- | -------------------------------------------------------- |
| **`id`**     | <code>string</code> | Unique identifier for the asset that had its volume set. |
| **`volume`** | <code>number</code> | Volume level that was set for the asset.                 |


#### SetAssetVolumeOptions

| Prop         | Type                | Description                                                                      |
| ------------ | ------------------- | -------------------------------------------------------------------------------- |
| **`id`**     | <code>string</code> | Unique identifier for the asset to set the volume for.                           |
| **`volume`** | <code>number</code> | Volume level for the asset. Range is from `0.0` (silent) to `1.0` (full volume). |


#### SetAssetRateResponse

| Prop       | Type                |
| ---------- | ------------------- |
| **`id`**   | <code>string</code> |
| **`rate`** | <code>number</code> |


#### SetAssetRateOptions

| Prop       | Type                | Description                                                                            |
| ---------- | ------------------- | -------------------------------------------------------------------------------------- |
| **`id`**   | <code>string</code> | Unique identifier for the asset to set the playback rate for.                          |
| **`rate`** | <code>number</code> | Playback rate for the asset. Range is from `0.5` (half speed) to `2.0` (double speed). |


#### SetAssetNumberOfLoopsResponse

| Prop                | Type                |
| ------------------- | ------------------- |
| **`id`**            | <code>string</code> |
| **`numberOfLoops`** | <code>number</code> |


#### SetAssetNumberOfLoopsOptions

| Prop                | Type                |
| ------------------- | ------------------- |
| **`id`**            | <code>string</code> |
| **`numberOfLoops`** | <code>number</code> |


#### SetAssetEnablePositionUpdatesResponse

| Prop                        | Type                 |
| --------------------------- | -------------------- |
| **`id`**                    | <code>string</code>  |
| **`enablePositionUpdates`** | <code>boolean</code> |


#### SetAssetEnablePositionUpdatesOptions

| Prop          | Type                 |
| ------------- | -------------------- |
| **`id`**      | <code>string</code>  |
| **`enabled`** | <code>boolean</code> |


#### SetAssetPositionUpdateIntervalResponse

| Prop                         | Type                |
| ---------------------------- | ------------------- |
| **`id`**                     | <code>string</code> |
| **`positionUpdateInterval`** | <code>number</code> |


#### SetAssetPositionUpdateIntervalOptions

| Prop                         | Type                |
| ---------------------------- | ------------------- |
| **`id`**                     | <code>string</code> |
| **`positionUpdateInterval`** | <code>number</code> |


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


#### AssetLoadedEvent

| Prop            | Type                       |
| --------------- | -------------------------- |
| **`eventName`** | <code>'assetLoaded'</code> |
| **`id`**        | <code>string</code>        |
| **`duration`**  | <code>number</code>        |


#### AssetUnloadedEvent

| Prop            | Type                         |
| --------------- | ---------------------------- |
| **`eventName`** | <code>'assetUnloaded'</code> |
| **`id`**        | <code>string</code>          |


#### AssetStartedEvent

| Prop            | Type                        |
| --------------- | --------------------------- |
| **`eventName`** | <code>'assetStarted'</code> |
| **`id`**        | <code>string</code>         |


#### AssetPausedEvent

| Prop            | Type                       |
| --------------- | -------------------------- |
| **`eventName`** | <code>'assetPaused'</code> |
| **`id`**        | <code>string</code>        |


#### AssetStoppedEvent

| Prop            | Type                        |
| --------------- | --------------------------- |
| **`eventName`** | <code>'assetStopped'</code> |
| **`id`**        | <code>string</code>         |


#### AssetSeekedEvent

| Prop              | Type                       |
| ----------------- | -------------------------- |
| **`eventName`**   | <code>'assetSeeked'</code> |
| **`id`**          | <code>string</code>        |
| **`currentTime`** | <code>number</code>        |


#### AssetCompletedEvent

| Prop            | Type                          |
| --------------- | ----------------------------- |
| **`eventName`** | <code>'assetCompleted'</code> |
| **`id`**        | <code>string</code>           |


#### AssetErrorEvent

| Prop            | Type                      |
| --------------- | ------------------------- |
| **`eventName`** | <code>'assetError'</code> |
| **`id`**        | <code>string</code>       |
| **`error`**     | <code>string</code>       |


#### AssetPositionUpdateEvent

| Prop              | Type                               |
| ----------------- | ---------------------------------- |
| **`eventName`**   | <code>'assetPositionUpdate'</code> |
| **`id`**          | <code>string</code>                |
| **`currentTime`** | <code>number</code>                |


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
