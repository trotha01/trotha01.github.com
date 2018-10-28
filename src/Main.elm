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
    , srcLink : String
    , playLink : String
    , coverImg : String
    , hovering : Bool
    , playing : Bool
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
      , srcLink = "https://github.com/trotha01/boxes-and-bubbles"
      , playLink = "https://trotha01.github.io/boxes-and-bubbles"
      , coverImg = "imgs/boxesandbubbles.png"
      , hovering = False
      , playing = False
      }
    , { title = "Noah's Ark"
      , description = "Playing around with physics"
      , srcLink = "https://github.com/trotha01/elm-noahsark"
      , playLink = "https://trotha01.github.io/elm-noahsark"
      , coverImg = "imgs/noahsark.png"
      , hovering = False
      , playing = False
      }
    , { title = "Snake"
      , description = "Implementing snake in elm"
      , srcLink = "https://github.com/trotha01/elm-snake"
      , playLink = "https://trotha01.github.io/elm-snake"
      , coverImg = "imgs/snake.png"
      , hovering = False
      , playing = False
      }
    , { title = "Safety Bubble"
      , description = "Elm February Game Jam Result"
      , srcLink = "https://github.com/trotha01/safetybubble"
      , playLink = "https://trotha01.github.io/safetybubble"
      , coverImg = "imgs/safetybubble.png"
      , hovering = False
      , playing = False
      }
    , { title = "Bee Game"
      , description = "Learn Spanish while traveling around the world as a bee."
      , srcLink = "https://github.com/trotha01/bee"
      , playLink = "https://trotha01.github.io/bee"
      , coverImg = "imgs/beegame.png"
      , hovering = False
      , playing = False
      }
    , { title = "Treadmill"
      , description = "Practice your spanish while making a cake."
      , srcLink = "https://github.com/trotha01/treadmill"
      , playLink = "https://trotha01.github.io/treadmill"
      , coverImg = "imgs/treadmill.png"
      , hovering = False
      , playing = False
      }
    ]



-- UPDATE


type Msg
    = InitialViewport Viewport
    | Resize Int Int
    | LeftTitle
    | RightTitle
    | PlayProject Project


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

        PlayProject project ->
            ( model |> mapProjects (playProject project), Cmd.none )


mapTitles : (Titles -> Titles) -> Model -> Model
mapTitles f model =
    { model | titles = f model.titles }


mapProjects : (List Project -> List Project) -> Model -> Model
mapProjects f model =
    { model | projects = f model.projects }


playProject : Project -> List Project -> List Project
playProject project projects =
    List.map
        (\p ->
            if p.title == project.title then
                { p | playing = True }

            else
                { p | playing = False }
        )
        projects


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
        [ style "max-width" "100%"
        ]
        [ viewProjects model
        , viewContact model
        , br [] []
        ]


viewContact : Model -> Html Msg
viewContact model =
    div [ class "page row" ]
        [ h2 [] [ text "Contact" ]
        , div []
            [ text "trotha01 at gmail" ]
        ]


viewProjects : Model -> Html Msg
viewProjects model =
    div [ class "page row" ]
        [ h2 [] [ text "Projects" ]
        , div
            [ class "project-list-wrapper"
            ]
            [ div [ class "project-list" ]
                (List.map viewProject model.projects)
            ]

        {--
         viewGame model.viewport model.projects
         --}
        ]


remFromInt : Int -> String
remFromInt x =
    String.fromInt x ++ "rem"


viewProject : Project -> Html Msg
viewProject project =
    a [ class "project", href project.playLink, target "_blank" ]
        [ div [ class "project-button" ]
            [ div [ class "col-1-of-5" ] [ img [ class "project-image", src project.coverImg ] [] ]
            , div [ class "col-4-of-5" ]
                [ h3 [ class "heading-tertiary" ] [ text project.title ]
                , p [ class "project-descriotion" ] [ text project.description ]
                ]
            ]
        ]


viewGame : Viewport -> List Project -> Html Msg
viewGame viewport projects =
    let
        activeProject =
            projects
                |> List.filter (\p -> p.playing)
                |> List.head
    in
    case activeProject of
        Nothing ->
            div [] []

        Just project ->
            div [ class "row" ]
                [ div
                    [ class "game-frame"
                    , style "height" (px viewport.viewport.height)
                    ]
                    [ iframe
                        [ src project.playLink
                        , style "height" "100%"
                        , style "width" "100%"
                        ]
                        []
                    ]
                ]


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
        , style "height" (px (model.viewport.viewport.height - 35))
        , style "background-position" "center"
        , style "background-repeat" "no-repeat"
        , style "background-size" "cover"
        ]
        [ headerText model ]


headerText : Model -> Html Msg
headerText model =
    div
        [ class "text" ]
        [ viewTitles model
        , arrows model
        , downArrow model
        ]


viewTitles : Model -> Html Msg
viewTitles model =
    div
        [ class "titles row"
        , style "position" "absolute"
        , style "top" <| px (model.viewport.viewport.height / 5)
        , style "left" "5rem"
        ]
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
    div [ class "arrows row" ]
        [ button
            [ class "arrow leftArrow button"
            , style "position" "absolute"
            , style "top" <| px ((model.viewport.viewport.height / 5) + 20)
            , Event.onClick LeftTitle
            ]
            [ leftArrow model ]
        , button
            [ class "arrow rightArrow button"
            , style "position" "absolute"
            , style "top" <| px ((model.viewport.viewport.height / 5) + 20)
            , Event.onClick RightTitle
            ]
            [ rightArrow model ]
        ]


downArrow : Model -> Html Msg
downArrow model =
    div
        [ class "down-arrow"
        , style "position" "absolute"
        , style "bottom" "0"
        , style "left" <| px (model.viewport.viewport.width / 2)
        , style "transform" "translate(-50%, 40%)"
        ]
        [ img
            [ {--src "imgs/arrow.svg"--}
              src "imgs/down-arrow-24px.svg"
            , width 100
            , height 100
            ]
            []
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
