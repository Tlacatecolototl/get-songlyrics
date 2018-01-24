Import-Module ps-spotify

while ($true) {
    $song =  Get-SpotifyTrackStatus -Port 4381
         if ($oldsong.track -ne $song.track ) {
            Write-Output "wee"
            $search = Invoke-RestMethod "https://genius.com/api/search/multi?per_page=5&q=$($song.track.artist_resource.name)%20$($song.track.track_resource.name)"
            $body = Invoke-WebRequest $search.response.sections.hits[0].result.url 
            $body.ParsedHtml.body.getElementsByClassName("lyrics") | select -ExpandProperty OuterText
        }
    $oldsong = Get-SpotifyTrackStatus -Port 4381
}