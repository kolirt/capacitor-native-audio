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
* [`pauseAllAssets()`](#pauseallassets)
* [`resumeAllAssets()`](#resumeallassets)
* [`getAssets()`](#getassets)
* [`preloadAsset(...)`](#preloadasset)
* [`unloadAsset(...)`](#unloadasset)
* [`getAssetState(...)`](#getassetstate)
* [`playAsset(...)`](#playasset)
* [`pauseAsset(...)`](#pauseasset)
* [`stopAsset(...)`](#stopasset)
* [`seekAsset(...)`](#seekasset)
* [`setAssetVolume(...)`](#setassetvolume)
* [`setAssetRate(...)`](#setassetrate)
* [`setAssetNumberOfLoops(...)`](#setassetnumberofloops)
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


### pauseAllAssets()

```typescript
pauseAllAssets() => Promise<PauseAllAssetsResponse>
```

**Returns:** <code>Promise&lt;<a href="#pauseallassetsresponse">PauseAllAssetsResponse</a>&gt;</code>

--------------------


### resumeAllAssets()

```typescript
resumeAllAssets() => Promise<ResumeAllAssetsResponse>
```

**Returns:** <code>Promise&lt;<a href="#resumeallassetsresponse">ResumeAllAssetsResponse</a>&gt;</code>

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

| Prop                                   | Type                                                                      |
| -------------------------------------- | ------------------------------------------------------------------------- |
| **`enableAutoInterruptionHandling`**   | <code>boolean</code>                                                      |
| **`enableAutoIosSessionDeactivation`** | <code>boolean</code>                                                      |
| **`positionUpdateInterval`**           | <code>number</code>                                                       |
| **`iosCategory`**                      | <code><a href="#avaudiosessioncategory">AVAudioSessionCategory</a></code> |
| **`iosMode`**                          | <code><a href="#avaudiosessionmode">AVAudioSessionMode</a></code>         |
| **`iosOptions`**                       | <code>AVAudioSessionCategoryOptions[]</code>                              |


#### PauseAllAssetsResponse

| Prop                 | Type                  |
| -------------------- | --------------------- |
| **`pausedAssetIds`** | <code>string[]</code> |


#### ResumeAllAssetsResponse

| Prop                  | Type                  |
| --------------------- | --------------------- |
| **`resumedAssetIds`** | <code>string[]</code> |


#### GetAssetsResponse

Asset

| Prop         | Type                  |
| ------------ | --------------------- |
| **`assets`** | <code>string[]</code> |


#### PreloadAssetResponse

| Prop           | Type                |
| -------------- | ------------------- |
| **`assetId`**  | <code>string</code> |
| **`duration`** | <code>number</code> |


#### PreloadAssetOptions

| Prop                | Type                |
| ------------------- | ------------------- |
| **`assetId`**       | <code>string</code> |
| **`source`**        | <code>string</code> |
| **`volume`**        | <code>number</code> |
| **`rate`**          | <code>number</code> |
| **`numberOfLoops`** | <code>number</code> |


#### UnloadAssetResponse

| Prop          | Type                |
| ------------- | ------------------- |
| **`assetId`** | <code>string</code> |


#### UnloadAssetOptions

| Prop          | Type                |
| ------------- | ------------------- |
| **`assetId`** | <code>string</code> |


#### GetAssetStateResponse

| Prop              | Type                 |
| ----------------- | -------------------- |
| **`assetId`**     | <code>string</code>  |
| **`isPlaying`**   | <code>boolean</code> |
| **`currentTime`** | <code>number</code>  |
| **`duration`**    | <code>number</code>  |


#### GetAssetStateOptions

| Prop          | Type                |
| ------------- | ------------------- |
| **`assetId`** | <code>string</code> |


#### PlayAssetResponse

| Prop            | Type                 |
| --------------- | -------------------- |
| **`assetId`**   | <code>string</code>  |
| **`isPlaying`** | <code>boolean</code> |


#### PlayAssetOptions

| Prop          | Type                |
| ------------- | ------------------- |
| **`assetId`** | <code>string</code> |


#### PauseAssetResponse

| Prop            | Type                 |
| --------------- | -------------------- |
| **`assetId`**   | <code>string</code>  |
| **`isPlaying`** | <code>boolean</code> |


#### PauseAssetOptions

| Prop          | Type                |
| ------------- | ------------------- |
| **`assetId`** | <code>string</code> |


#### StopAssetResponse

| Prop            | Type                 |
| --------------- | -------------------- |
| **`assetId`**   | <code>string</code>  |
| **`isPlaying`** | <code>boolean</code> |


#### StopAssetOptions

| Prop          | Type                |
| ------------- | ------------------- |
| **`assetId`** | <code>string</code> |


#### SeekAssetResponse

| Prop              | Type                |
| ----------------- | ------------------- |
| **`assetId`**     | <code>string</code> |
| **`currentTime`** | <code>number</code> |


#### SeekAssetOptions

| Prop          | Type                |
| ------------- | ------------------- |
| **`assetId`** | <code>string</code> |
| **`time`**    | <code>number</code> |


#### SetAssetVolumeResponse

| Prop          | Type                |
| ------------- | ------------------- |
| **`assetId`** | <code>string</code> |
| **`volume`**  | <code>number</code> |


#### SetAssetVolumeOptions

| Prop          | Type                |
| ------------- | ------------------- |
| **`assetId`** | <code>string</code> |
| **`volume`**  | <code>number</code> |


#### SetAssetRateResponse

| Prop          | Type                |
| ------------- | ------------------- |
| **`assetId`** | <code>string</code> |
| **`rate`**    | <code>number</code> |


#### SetAssetRateOptions

| Prop          | Type                |
| ------------- | ------------------- |
| **`assetId`** | <code>string</code> |
| **`rate`**    | <code>number</code> |


#### SetAssetNumberOfLoopsResponse

| Prop                | Type                |
| ------------------- | ------------------- |
| **`assetId`**       | <code>string</code> |
| **`numberOfLoops`** | <code>number</code> |


#### SetAssetNumberOfLoopsOptions

| Prop                | Type                |
| ------------------- | ------------------- |
| **`assetId`**       | <code>string</code> |
| **`numberOfLoops`** | <code>number</code> |


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
| **`assetId`**   | <code>string</code>        |
| **`duration`**  | <code>number</code>        |


#### AssetUnloadedEvent

| Prop            | Type                         |
| --------------- | ---------------------------- |
| **`eventName`** | <code>'assetUnloaded'</code> |
| **`assetId`**   | <code>string</code>          |


#### AssetStartedEvent

| Prop            | Type                        |
| --------------- | --------------------------- |
| **`eventName`** | <code>'assetStarted'</code> |
| **`assetId`**   | <code>string</code>         |


#### AssetPausedEvent

| Prop            | Type                       |
| --------------- | -------------------------- |
| **`eventName`** | <code>'assetPaused'</code> |
| **`assetId`**   | <code>string</code>        |


#### AssetStoppedEvent

| Prop            | Type                        |
| --------------- | --------------------------- |
| **`eventName`** | <code>'assetStopped'</code> |
| **`assetId`**   | <code>string</code>         |


#### AssetSeekedEvent

| Prop              | Type                       |
| ----------------- | -------------------------- |
| **`eventName`**   | <code>'assetSeeked'</code> |
| **`assetId`**     | <code>string</code>        |
| **`currentTime`** | <code>number</code>        |


#### AssetCompletedEvent

| Prop            | Type                          |
| --------------- | ----------------------------- |
| **`eventName`** | <code>'assetCompleted'</code> |
| **`assetId`**   | <code>string</code>           |


#### AssetErrorEvent

| Prop            | Type                      |
| --------------- | ------------------------- |
| **`eventName`** | <code>'assetError'</code> |
| **`assetId`**   | <code>string</code>       |
| **`error`**     | <code>string</code>       |


#### AssetPositionUpdateEvent

| Prop              | Type                               |
| ----------------- | ---------------------------------- |
| **`eventName`**   | <code>'assetPositionUpdate'</code> |
| **`assetId`**     | <code>string</code>                |
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
