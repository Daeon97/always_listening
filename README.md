# always_listening
When the flutter app is launched, the api calls counter bloc does all the work
First it subscribes to a timer stream which executes events every 5 seconds.
The current implement does this only when the app is in foreground. Once it leaves
foreground the timer stream is unsubscribed, but the app still listens for audio
in the background on the Kotlin side.

At 5 seconds intervals it invokes the method channel and gets the audio stream from the
kotlin side and sends it to the create wav use case. The result from create wav use case 
is then sent to the send audio wav use case and whatever this returns is persisted by hydrated bloc
