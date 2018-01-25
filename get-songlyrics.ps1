Import-Module ps-spotify
Add-Type -path $PSScriptRoot\HtmlAgilityPack.dll
while ($true) {
    $song =  Get-SpotifyCurrentlyPlaying
         if ($oldsong.track -ne $song.item ) {
            $search = Invoke-RestMethod "https://genius.com/api/search/multi?per_page=5&q=$($song.item.name)%20$($song.item.artists.name)"
            $html = New-Object HtmlAgilityPack.HtmlWeb
            $res = $html.Load("$($search.response.sections.hits[0].result.url)")
            $res.DocumentNode.SelectSingleNode("//p").innertext
        }
    $oldsong = Get-SpotifyCurrentlyPlaying
}