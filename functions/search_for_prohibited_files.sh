function search_for_prohibited_files () {
	
	rm possible_prohibited_files.txt

	printf "\nPossible prohibited images:\n\n" >> possible_prohibited_files.txt

	find / -type f -name "*.jpg" >> possible_prohibited_files.txt
	find / -type f -name "*.jpeg" >> possible_prohibited_files.txt
	find / -type f -name "*.gif" >> possible_prohibited_files.txt
	find / -type f -name "*.png" >> possible_prohibited_files.txt
	find / -type f -name "*.bmp" >> possible_prohibited_files.txt

	printf "\nPossible prohibited videos:\n\n" >> possible_prohibited_files.txt

	find / -type f -name "*.mp4" >> possible_prohibited_files.txt
	find / -type f -name "*.mov" >> possible_prohibited_files.txt
	find / -type f -name "*.wmv" >> possible_prohibited_files.txt
	find / -type f -name "*.avi" >> possible_prohibited_files.txt
	find / -type f -name "*.mkv" >> possible_prohibited_files.txt

	printf "\nPossible prohibited music files:\n\n" >> possible_prohibited_files.txt

	find / -type f -name "*.mp3" >> possible_prohibited_files.txt
	find / -type f -name "*.aac" >> possible_prohibited_files.txt
	find / -type f -name "*.flac" >> possible_prohibited_files.txt
	find / -type f -name "*.alac" >> possible_prohibited_files.txt
	find / -type f -name "*.wav" >> possible_prohibited_files.txt
}