ffmpeg -i out_trailer.mp4 -i logo_no_background.png -filter_complex "[1:v]format=rgba[logo];[0:v][logo]overlay=x=20:y=20:enable='between(t,2,8)'" -c:a copy output_with_logo.mp4
ffmpeg -i output_with_logo.mp4 -vf "drawtext=fontfile=./federo.ttf:text='Interstellar - trailer - 720p':x=10:y=690:fontsize=20:fontcolor=white" final_output.mp4
