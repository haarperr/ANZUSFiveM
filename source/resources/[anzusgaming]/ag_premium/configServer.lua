ConfigServer = {}

-- Premium level required for custom plates
ConfigServer.PlatePremiumLevel = 3

-- Premium level required for custom phone numbers
ConfigServer.PhonePremiumLevel = 3

-- List of blacklisted regex patterns
-- Use this to filter out profanity, etc.
-- Use https://gitspartv.github.io/lua-patterns/ to see what the patterns do.
ConfigServer.Filter =
{
    "^ +", -- " " (Empty string)
    "r[a4]p[e3]", -- "rape"
    "[s5][li][uv][t7]", -- "slut"
    "b[i1][t7]ch", -- "bitch"
    "c[o0]n", -- "coon"
    "f[a4][g9]+", -- "fag"
    "h[o0]+m[o0]+s+", -- "homos"
    "k *y *[s5]", -- "kys"
    "wh[o0][r52][e3]", -- "whore"
    "[kn]+[ceq]+ *g+a+", -- "nicker"
    "[kn]+[il1][ceqk]* *g*[eu]r+", -- "nick gur"
    "[kn]+[il1][ge69]+[a4]+", -- "nigga"
    "[kn]+[il1][ge69q]+[e3][r52]+", -- "nigger"
    "[s5][uv][il]c[il]d[e3]", -- "suicide"
    "f[a4]*[g9]+[o0]*[t7]", -- "faggot"
}

-- Edit this to what ever you guys use for logging
ConfigServer.Log = function(message)
    print(message)
end
