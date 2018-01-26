Import-Module ps-spotify
Add-Type -path $PSScriptRoot\HtmlAgilityPack.dll

while ($true) {
    $song =  Get-SpotifyCurrentlyPlaying
         if ($oldsong -ne $song.item.name ) {
            clear-host
            $search = Invoke-RestMethod "https://genius.com/api/search/multi?per_page=5&q=$($song.item.name)%20$($song.item.artists.name)"
            $html = New-Object HtmlAgilityPack.HtmlWeb
            $lyrics = (($html.Load("$($search.response.sections.hits[0].result.url)")).DocumentNode.SelectSingleNode("//p").innertext).split("`n")
            $oldsong = (Get-SpotifyCurrentlyPlaying).item.name
            foreach ($line in $lyrics) {
                $a = $(" " * [math]::max( 0, (($host.ui.RawUI.BufferSize.Width / 2) - ($line.Length / 2))))
                write-host -nonewline "$a"
                write-host -nonewline "$line"
                write-host -nonewline "`n"
            }
        }
        start-sleep -seconds 2
}
