module Page.Contact exposing (Model, Msg, init, view, update)

import Css exposing (..)
import Html exposing (Html, button, div, text, a, p, ul, li, img)
import Html.Attributes as Attr
import Html.Events as Event exposing (defaultOptions)
import Json.Decode as Json
import Route
import Page.Header as Header
import Page.Helper as Helper
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


view : (String -> msg) -> Window.Size -> Model -> Html msg
view onClick window model =
    Helper.topImageView window topImage (contact onClick)


topImage : Html a
topImage =
    Helper.topImage "imgs/carrier-pigeon.svg" []


linkedInUrl =
    "https://www.linkedin.com/in/trevorrothaus/"


contact : (String -> msg) -> Html msg
contact onClick =
    div
        [ styles
            [ padding2 (px 0) (px 100)
            ]
        ]
        [ Html.text "How to reach me..."
        , Html.ol
            [ styles [ listStyleType none ]
            ]
            [ contactItem "1" <|
                contactDescription "trotha01 at gmail"
            , contactItem "2" <|
                a
                    [ Attr.href linkedInUrl
                    , Event.onWithOptions
                        "click"
                        { defaultOptions | preventDefault = True }
                        (Json.succeed (onClick linkedInUrl))
                    , styles
                        [ textDecoration none
                        , color (hsl 0 0 0)
                        , cursor pointer
                        ]
                    ]
                    [ contactDescription "LinkedIn" ]
            ]
        ]


contactDescription : String -> Html msg
contactDescription str =
    Html.span
        [ styles
            [ fontSize (em 0.5)
            , marginLeft (px 10)
            , color (hsl 0 0 0)
            , fontFamilies [ "Helvetica", "sans-serif" ]
            ]
        ]
        [ Html.text str ]


contactItem : String -> Html msg -> Html msg
contactItem num contact =
    li
        [ styles
            [ position relative
            , color (hsl 203 0.2 0.44)
            , fontSize (em 3)
            ]
        ]
        [ Html.span
            [ styles
                [ fontStyle italic
                , fontFamilies [ "Helvetica", "Verdana", "sans-serif" ]
                ]
            ]
            [ Html.text num ]
        , contact
        ]



-- STYLE


styles =
    (Css.asPairs >> Attr.style)
