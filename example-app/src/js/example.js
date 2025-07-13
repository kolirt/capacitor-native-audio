import { NativeAudio } from '@kolirt/capacitor-native-audio';

window.testEcho = () => {
    const inputValue = document.getElementById("echoInput").value;
    NativeAudio.echo({ value: inputValue })
}
