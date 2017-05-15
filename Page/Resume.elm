module Page.Resume exposing (Model, Msg, init, view, update)

import Css exposing (..)
import Html exposing (Html, button, div, text, a, p, ul, li, span, h1, embed)
import Html.Attributes as Attr
import Route
import Page.Header as Header
import Window


-- MODEL


type alias Model =
    {}


init : Model
init =
    {}



-- UPDATE


type Msg
    = HeaderMsg Header.Msg


update : Msg -> Model -> Model
update msg model =
    model



-- View


view : Window.Size -> Model -> Html Msg
view window model =
    div [] [ resume window ]



{-
   TODO: add pdf download button
-}


resume : Window.Size -> Html msg
resume window =
    div
        [ styles
            [ padding (px 10)
            ]
        ]
        [ Html.iframe
            [ -- Attr.src "imgs/Rothaus_Resume.pdf"
              Attr.src "https://docs.google.com/viewer?srcid=1ADJVDEkWIu0BQFGfS6JkJUUgS3mDyhh_lLsTslAUW0E&pid=explorer&efh=false&a=v&chrome=false&embedded=true"
            , styles
                [ width (px <| toFloat window.width - 60)
                , height (px <| toFloat window.height - 110)
                , property "frameborder" "0"
                ]
            ]
            []
          {-
             <iframe src="http://docs.google.com/gview?url=http://path.com/to/your/pdf.pdf&embedded=true"
             style="width:600px; height:500px;" frameborder="0"></iframe>
          -}
          {-
             embed
               [ Attr.src "imgs/Rothaus_Resume.pdf"
               , styles
                   [ width (px 800)
                   , height (px 2100)
                   ]
               ]
               []
          -}
        ]



-- STYLE


styles =
    (Css.asPairs >> Attr.style)
