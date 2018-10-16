module Main exposing (main)

import Browser exposing (..)
import Browser.Dom exposing (..)
import Browser.Events exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events as Event exposing (..)
import List.Zipper as Zipper exposing (..)
import Task


main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- Model


type alias Model =
    { viewport : Viewport
    , titles : Titles
    , projects : List Project
    }


type alias Titles =
    Zipper Title


type alias Title =
    { name : String
    , img : String
    }


type alias Project =
    { title : String
    , description : String
    , link : String
    , coverImg : String
    }


type alias Flags =
    {}


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { viewport = initViewport
      , titles = initTitles
      , projects = initProjects
      }
    , Task.perform InitialViewport getViewport
    )


initViewport =
    { scene =
        { width = 0
        , height = 0
        }
    , viewport =
        { x = 0
        , y = 0
        , width = 0
        , height = 0
        }
    }


initTitles : Titles
initTitles =
    Zipper.fromList
        [ { name = "Pedagogy Enthusiast", img = "hotairbaloon.jpg" }
        , { name = "Frontend Engineer", img = "bioluminescence.jpg" }
        , { name = "Backend Engineer", img = "construction.jpg" }
        ]
        |> Zipper.withDefault { name = "Pedagogy Enthusiast & Software Engineer", img = "" }


initProjects : List Project
initProjects =
    [ { title = "Boxes and Bubbles"
      , description = "An exporation into collision detection."
      , link = "https://github.com/trotha01/boxes-and-bubbles"
      , coverImg = "imgs/boxesandbubbles.png"
      }
    , { title = "Bee Game"
      , description = "Learn Spanish while traveling around the world as a bee."
      , link = "https://github.com/trotha01/bee"
      , coverImg = "imgs/beegame.png"
      }
    , { title = "Safety Bubble"
      , description = "Elm February Game Jam Result"
      , link = "https://github.com/trotha01/safetybubble"
      , coverImg = "imgs/safetybubble.png"
      }
    , { title = "Treadmill"
      , description = "Practice your spanish while making a cake."
      , link = "https://github.com/trotha01/treadmill"
      , coverImg = "imgs/treadmill.png"
      }
    ]



-- UPDATE


type Msg
    = InitialViewport Viewport
    | Resize Int Int
    | LeftTitle
    | RightTitle


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InitialViewport viewport ->
            ( { model | viewport = viewport }, Cmd.none )

        Resize x y ->
            ( model, Task.perform InitialViewport getViewport )

        LeftTitle ->
            ( model |> mapTitles previousTitle, Cmd.none )

        RightTitle ->
            ( model |> mapTitles nextTitle, Cmd.none )


mapTitles : (Titles -> Titles) -> Model -> Model
mapTitles f model =
    { model | titles = f model.titles }


nextTitle : Titles -> Titles
nextTitle titles =
    Zipper.next titles
        |> Maybe.withDefault (Zipper.first titles)


previousTitle : Titles -> Titles
previousTitle titles =
    Zipper.previous titles
        |> Maybe.withDefault (Zipper.last titles)



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ injectStyle
        , headerRow model
        , pages model
        ]


pages : Model -> Html Msg
pages model =
    div
        [ style "position" "absolute"
        , style "top" (px model.viewport.viewport.height)
        , style "width" "100%"
        ]
        [ projects model
        , viewResumeLink model
        , br [] []
        ]


viewResumeLink : Model -> Html Msg
viewResumeLink model =
    div [ class "page row" ]
        [ button [ class "resumeButton" ]
            [ text "Resume" ]
        ]


projects : Model -> Html Msg
projects model =
    div [ class "page row" ]
        [ h2 [] [ text "Projects" ]
        , div [] (List.map viewProject model.projects)
        ]


viewProject : Project -> Html Msg
viewProject project =
    div [ class "project col-1-of-3" ]
        [ a [ class "project-button", href project.link, target "_blank" ]
            [ div [] [ img [ class "project-image", src project.coverImg ] [] ]
            , h3 [ class "heading-tertiary" ] [ text project.title ]
            , text project.description
            ]
        ]


projectBackground : Html Msg
projectBackground =
    div [ class "project-background" ] []


headerRow : Model -> Html Msg
headerRow model =
    div [ class "row" ]
        [ header model
        ]


header : Model -> Html Msg
header model =
    let
        img =
            .img <| current model.titles
    in
    div
        [ class "header"
        , style "background-image" ("linear-gradient(transparent 80%, #131416), url(imgs/" ++ img ++ ")")
        , style "min-height" "500px"
        , style "background-position" "center"
        , style "background-repeat" "no-repeat"
        , style "background-size" "cover"
        ]
        [ headerText model ]


headerText : Model -> Html Msg
headerText model =
    div
        [ class "text"
        , style "width" "100%"
        ]
        [ viewTitles model
        , arrows model
        ]


viewTitles : Model -> Html Msg
viewTitles model =
    div [ class "row" ]
        [ viewTitle model
        , viewSubTitle model
        ]


viewTitle : Model -> Html Msg
viewTitle model =
    h1 [ style "color" "white" ] [ text "Trevor Rothaus" ]


viewSubTitle : Model -> Html Msg
viewSubTitle model =
    h4
        [ class "subtitle"
        , style "color" "white"
        ]
        [ text <| .name <| current model.titles
        ]


arrows : Model -> Html Msg
arrows model =
    div [ class "arrows" ]
        [ button [ class "leftArrow button", Event.onClick LeftTitle ] [ leftArrow model ]
        , button [ class "rightArrow button", Event.onClick RightTitle ] [ rightArrow model ]
        ]


leftArrow : Model -> Html Msg
leftArrow model =
    div
        [ class "button" ]
        [ text "<" ]


rightArrow : Model -> Html Msg
rightArrow model =
    div
        [ class "button" ]
        [ text ">" ]


injectStyle : Html Msg
injectStyle =
    node "link"
        [ attribute "rel" "stylesheet"
        , attribute "href" "style/bio.css"
        , attribute "type" "text/css"
        ]
        []


px : Float -> String
px x =
    String.fromFloat x ++ "px"



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Browser.Events.onResize Resize
