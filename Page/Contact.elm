module Page.Contact exposing (Model, Msg, init, view, update)

import Css exposing (..)
import Html exposing (Html, button, div, text, a, p, ul, li, img)
import Html.Attributes as Attr
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


view : Window.Size -> Model -> Html Msg
view window model =
    Helper.topImageView window topImage contact


topImage : Html a
topImage =
    Helper.topImage "imgs/mail.svg" []


contact : Html msg
contact =
    div
        [ styles
            [ padding (px 100)
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
                    [ Attr.href "https://www.linkedin.com/in/trevorrothaus/"
                    , Attr.target "_blank"
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
