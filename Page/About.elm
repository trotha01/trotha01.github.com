module Page.About exposing (Model, Msg, init, view, update)

import Css exposing (..)
import Html exposing (Html, button, div, text, a, p)
import Html.Attributes
import Route
import Page.Header as Header


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


view : Model -> Html Msg
view model =
    div [] [ about ]


about : Html msg
about =
    div
        [ styles
            [ padding (px 10)
            ]
        ]
        [ p []
            [ Html.text "My name is Trevor Rothaus, I'm a computer programmer, a pedagogy enthusiast and my passion is in improving education." ]
        , p [] [ Html.text "I grew up in Orange County, California, moved to Boston for college at Tufts University, then moved back to Orange County for a career in software." ]
        , p [] [ Html.text "As a pedagogy enthusiast, I understand the best way to learn is not through lectures and not through reading a book, but through interactivity. So I my dream is to design and create educational games." ]
        ]



-- STYLE


styles =
    (Css.asPairs >> Html.Attributes.style)
