# always_listening
When the flutter app is launched it invokes the Kotlin code through a method channel. The
Kotlin side starts a foreground service that for now records a one time 6 seconds audio, 
saves the audio as mp4 with the name Audio.mp4 and thereafter releases the microphone. The
Flutter side meanwhile continuously polls the app storage directory for an mp4
file every 10 seconds. It takes this mp4 file and converts it to a wav file which it
then sends to the API. The result of the network request, a transcription is then cached and
the last 3 transcriptions are shown together with the number of times the network request was
made if any. The app is not 100% done (about 90% done actually just need make the Service
continuously listen to the microphone and save 5 seconds long audio, fix up the BLoC,
fix the remote data source implementation sendAudioWav function and add some tests to the Kotlin
part) but this is the intended idea or rather more like a proof of concept idea
