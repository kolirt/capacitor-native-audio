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
configureSession(options: { enableAutoInterruptionHandling?: boolean; enableAutoIosSessionActivation?: boolean; iosCategory?: string; iosMode?: string; iosOptions?: string[]; }) => Promise<{ enableAutoHandling: boolean; iosCategory?: AVAudioSessionCategory; iosMode?: AVAudioSessionMode; iosOptions?: AVAudioSessionCategoryOptions[]; }>
```

| Param         | Type                                                                                                                                                                |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **`options`** | <code>{ enableAutoInterruptionHandling?: boolean; enableAutoIosSessionActivation?: boolean; iosCategory?: string; iosMode?: string; iosOptions?: string[]; }</code> |

**Returns:** <code>Promise&lt;{ enableAutoHandling: boolean; iosCategory?: <a href="#avaudiosessioncategory">AVAudioSessionCategory</a>; iosMode?: <a href="#avaudiosessionmode">AVAudioSessionMode</a>; iosOptions?: AVAudioSessionCategoryOptions[]; }&gt;</code>

--------------------


### pauseAllAssets()

```typescript
pauseAllAssets() => Promise<{ pausedAssetIds: string[]; }>
```

**Returns:** <code>Promise&lt;{ pausedAssetIds: string[]; }&gt;</code>

--------------------


### resumeAllAssets()

```typescript
resumeAllAssets() => Promise<{ resumedAssetIds: string[]; }>
```

**Returns:** <code>Promise&lt;{ resumedAssetIds: string[]; }&gt;</code>

--------------------


### getAssets()

```typescript
getAssets() => Promise<{ assets: string[]; }>
```

Asset

**Returns:** <code>Promise&lt;{ assets: string[]; }&gt;</code>

--------------------


### preloadAsset(...)

```typescript
preloadAsset(options: { assetId: string; source: string; volume?: number; rate?: number; numberOfLoops?: number; }) => Promise<{ assetId: string; duration: number; }>
```

| Param         | Type                                                                                                      |
| ------------- | --------------------------------------------------------------------------------------------------------- |
| **`options`** | <code>{ assetId: string; source: string; volume?: number; rate?: number; numberOfLoops?: number; }</code> |

**Returns:** <code>Promise&lt;{ assetId: string; duration: number; }&gt;</code>

--------------------


### unloadAsset(...)

```typescript
unloadAsset(options: { assetId: string; }) => Promise<{ assetId: string; }>
```

| Param         | Type                              |
| ------------- | --------------------------------- |
| **`options`** | <code>{ assetId: string; }</code> |

**Returns:** <code>Promise&lt;{ assetId: string; }&gt;</code>

--------------------


### getAssetState(...)

```typescript
getAssetState(options: { assetId: string; }) => Promise<{ assetId: string; isPlaying: boolean; currentTime: number; duration: number; }>
```

| Param         | Type                              |
| ------------- | --------------------------------- |
| **`options`** | <code>{ assetId: string; }</code> |

**Returns:** <code>Promise&lt;{ assetId: string; isPlaying: boolean; currentTime: number; duration: number; }&gt;</code>

--------------------


### playAsset(...)

```typescript
playAsset(options: { assetId: string; }) => Promise<{ assetId: string; isPlaying: boolean; }>
```

| Param         | Type                              |
| ------------- | --------------------------------- |
| **`options`** | <code>{ assetId: string; }</code> |

**Returns:** <code>Promise&lt;{ assetId: string; isPlaying: boolean; }&gt;</code>

--------------------


### pauseAsset(...)

```typescript
pauseAsset(options: { assetId: string; }) => Promise<{ assetId: string; isPlaying: boolean; }>
```

| Param         | Type                              |
| ------------- | --------------------------------- |
| **`options`** | <code>{ assetId: string; }</code> |

**Returns:** <code>Promise&lt;{ assetId: string; isPlaying: boolean; }&gt;</code>

--------------------


### stopAsset(...)

```typescript
stopAsset(options: { assetId: string; }) => Promise<{ assetId: string; isPlaying: boolean; }>
```

| Param         | Type                              |
| ------------- | --------------------------------- |
| **`options`** | <code>{ assetId: string; }</code> |

**Returns:** <code>Promise&lt;{ assetId: string; isPlaying: boolean; }&gt;</code>

--------------------


### seekAsset(...)

```typescript
seekAsset(options: { assetId: string; time: number; }) => Promise<{ assetId: string; currentTime: number; }>
```

| Param         | Type                                            |
| ------------- | ----------------------------------------------- |
| **`options`** | <code>{ assetId: string; time: number; }</code> |

**Returns:** <code>Promise&lt;{ assetId: string; currentTime: number; }&gt;</code>

--------------------


### setAssetVolume(...)

```typescript
setAssetVolume(options: { assetId: string; volume: number; }) => Promise<{ assetId: string; volume: number; }>
```

| Param         | Type                                              |
| ------------- | ------------------------------------------------- |
| **`options`** | <code>{ assetId: string; volume: number; }</code> |

**Returns:** <code>Promise&lt;{ assetId: string; volume: number; }&gt;</code>

--------------------


### setAssetRate(...)

```typescript
setAssetRate(options: { assetId: string; rate: number; }) => Promise<{ assetId: string; rate: number; }>
```

| Param         | Type                                            |
| ------------- | ----------------------------------------------- |
| **`options`** | <code>{ assetId: string; rate: number; }</code> |

**Returns:** <code>Promise&lt;{ assetId: string; rate: number; }&gt;</code>

--------------------


### setAssetNumberOfLoops(...)

```typescript
setAssetNumberOfLoops(options: { assetId: string; numberOfLoops: number; }) => Promise<{ assetId: string; numberOfLoops: number; }>
```

| Param         | Type                                                     |
| ------------- | -------------------------------------------------------- |
| **`options`** | <code>{ assetId: string; numberOfLoops: number; }</code> |

**Returns:** <code>Promise&lt;{ assetId: string; numberOfLoops: number; }&gt;</code>

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


#### PluginListenerHandle

| Prop         | Type                                      |
| ------------ | ----------------------------------------- |
| **`remove`** | <code>() =&gt; Promise&lt;void&gt;</code> |


### Type Aliases


#### AVAudioSessionCategory

<code>'ambient' | 'multiRoute' | 'playAndRecord' | 'playback' | 'record' | 'soloAmbient'</code>


#### AVAudioSessionMode

<code>'default' | 'gameChat' | 'measurement' | 'moviePlayback' | 'spokenAudio' | 'videoChat' | 'videoRecording' | 'voiceChat' | 'voicePrompt'</code>


#### AVAudioSessionCategoryOptions

<code>'mixWithOthers' | 'duckOthers' | 'interruptSpokenAudioAndMixWithOthers' | 'allowBluetoothA2DP' | 'allowAirPlay' | 'defaultToSpeaker' | 'overrideMutedMicrophoneInterruption'</code>


#### SessionInterruptedEvent

<code>{ eventName: 'sessionInterrupted'; state: 'began' | 'ended' }</code>


#### SessionRouteChangedEvent

<code>{ eventName: 'sessionRouteChanged'; reason: number }</code>


#### AssetLoadedEvent

<code>{ eventName: 'assetLoaded'; assetId: string; duration: number }</code>


#### EventListener

<code>(data: T): void</code>


#### AssetUnloadedEvent

<code>{ eventName: 'assetUnloaded'; assetId: string }</code>


#### AssetStartedEvent

<code>{ eventName: 'assetStarted'; assetId: string }</code>


#### AssetPausedEvent

<code>{ eventName: 'assetPaused'; assetId: string }</code>


#### AssetStoppedEvent

<code>{ eventName: 'assetStopped'; assetId: string }</code>


#### AssetSeekedEvent

<code>{ eventName: 'assetSeeked'; assetId: string; currentTime: number }</code>


#### AssetCompletedEvent

<code>{ eventName: 'assetCompleted'; assetId: string }</code>


#### AssetErrorEvent

<code>{ eventName: 'assetError'; assetId: string; error: string }</code>


#### AssetPositionUpdateEvent

<code>{ eventName: 'assetPositionUpdate'; assetId: string; currentTime: number }</code>

</docgen-api>
