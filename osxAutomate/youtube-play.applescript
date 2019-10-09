to clickClassName(theClassName, elementnum) -- Handler for pausing YouTube in Chrome
	if application "Vivaldi" is running then
		try
			tell application "Vivaldi" to (tabs of window 1 whose URL contains "www.youtube")
			set youtubeTabs to item 1 of the result
			tell application "Vivaldi"
				execute youtubeTabs javascript "document.getElementsByClassName('" & theClassName & "')[" & elementnum & "].click();"
			end tell
		end try
		
	else if application "Google Chrome" is running then
		try
			tell application "Google Chrome" to (tabs of window 1 whose URL contains "youtube")
			set youtubeTabs to item 1 of the result
			tell application "Google Chrome"
				execute youtubeTabs javascript "document.getElementsByClassName('" & theClassName & "')[" & elementnum & "].click();"
			end tell
		end try
		try
			tell application "Google Chrome" to (tabs of window 2 whose URL contains "youtube")
			set youtubeTabs to item 1 of the result
			tell application "Google Chrome"
				execute youtubeTabs javascript "document.getElementsByClassName('" & theClassName & "')[" & elementnum & "].click();"
			end tell
		end try
	end if
end clickClassName

clickClassName("ytp-play-button ytp-button", 0)