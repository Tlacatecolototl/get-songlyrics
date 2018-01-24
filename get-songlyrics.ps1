Import-Module ps-spotify

while ($true) {
    $song =  Get-SpotifyCurrentlyPlaying
         if ($oldsong.track -ne $song.item ) {
            Write-Output "wee"
            $search = Invoke-RestMethod "https://genius.com/api/search/multi?per_page=5&q=$($song.item.name)%20$($song.item.artists.name)"
            $body = Invoke-WebRequest $search.response.sections.hits[0].result.url 
            $body.ParsedHtml.body.getElementsByClassName("lyrics") | select -ExpandProperty OuterText
        }
    $oldsong = Get-SpotifyCurrentlyPlaying
}