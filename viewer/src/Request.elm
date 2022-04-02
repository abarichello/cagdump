module Request exposing (DumpData(..), fetchData)

import Http


type DumpData
    = JSON (Result Http.Error String)


archiveEndpoint : String
archiveEndpoint =
    "https://cagdump.barichello.me/CCO-2016-2021.json"


debugEndpoint : String
debugEndpoint =
    "http://localhost:8000/output/CCO-2016-2021.json"


fetchData : Bool -> Cmd DumpData
fetchData debug =
    Http.get
        { url =
            if debug then
                debugEndpoint

            else
                archiveEndpoint
        , expect = Http.expectString JSON
        }
