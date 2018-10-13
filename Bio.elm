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
    , experience : List Experience
    , education : List Education
    , skills : Skills
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


type alias Experience =
    { title : String
    , date : String
    , tasks : List Task
    }


type alias Education =
    { school : String
    , graduation : String
    , degree : String
    , minor : String
    , gpa : Float
    , deansList : Bool
    }


type alias Skills =
    { csLanguages : List String
    , other : List String
    }


type alias Task =
    { summary : String }


type alias Flags =
    {}


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { viewport = initViewport
      , titles = initTitles
      , projects = initProjects
      , experience = initExperience
      , education = initEducation
      , skills = initSkills
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
      , description = "An exporation into collision detection with, as the name implies, boxes and bubbles."
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


initExperience : List Experience
initExperience =
    [ { title = "SendGrid Software Engineer"
      , date = "June 2014 - Present"
      , tasks =
            [ { summary = "Created scalable, partition tolerant, and available systems for aggregating and storing marketing stats with at-most-once delivery, handling up to 45k events/s." }
            , { summary = "Created a process that would stream data to Kafka on virtually every node in production to ensure a minimal amount of lost events, logs, and stats." }
            , { summary = "Revamped SendGrid’s signup/upgrade/downgrade to be PCI compliant, user friendly, and scalable." }
            , { summary = "Optimized our Database Abstraction Layer, used by nearly every service, to handle double the load." }
            , { summary = "Presented at Golang meetups, Functional Programming meetups, as well as company brown bag events." }
            ]
      }
    , { title = "DIRECTV Software Engineer Intern"
      , date = "May - Aug 2013"
      , tasks =
            [ { summary = "Created scalable, partition tolerant, and available systems for aggregating and storing marketing stats with at-most-once delivery, handling up to 45k events/s." }
            , { summary = "Created a process that would stream data to Kafka on virtually every node in production to ensure a minimal amount of lost events, logs, and stats." }
            , { summary = "Revamped SendGrid’s signup/upgrade/downgrade to be PCI compliant, user friendly, and scalable." }
            , { summary = "Optimized our Database Abstraction Layer, used by nearly every service, to handle double the load." }
            ]
      }
    , { title = "DIRECTV Test Engineer Intern (Ultimate Staffing)"
      , date = "May - Aug 2011/2012"
      , tasks =
            [ { summary = "Profiled and improved department automation tool, cutting it from an hour to a few seconds." }
            , { summary = "Performed acceptance and regression testing on legacy and bleeding edge Set Top Box Products." }
            ]
      }
    ]


initEducation : List Education
initEducation =
    [ { school = "Tufts University"
      , graduation = "May 2014"
      , degree = "Bachelor of Sciences in Computer Science"
      , minor = "Mathematics Minor"
      , gpa = 3.52
      , deansList = True
      }
    ]


initSkills : Skills
initSkills =
    { csLanguages = [ "Golang", "Elm", "Javascript", "Html", "CSS", "Haskell", "Python", "Perl", "Ruby", "C", "C++", "Bash Script" ]
    , other = [ "Mysql", "Linux", "Git", "Vim", "Chef", "Linux Tooling (ss, strace, ps, pgrep, ngrep, tcpdump, top, etc)" ]
    }



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
        , viewExperiences model
        , div [] (List.map viewEducation model.education)
        , technicalSkills model
        , contact model
        ]


viewExperiences : Model -> Html Msg
viewExperiences model =
    div [ class "page row" ]
        [ h2 [] [ text "Experience" ]
        , div [] (List.map viewExperience model.experience)
        ]


viewExperience : Experience -> Html Msg
viewExperience experience =
    div []
        [ h3 [] [ text experience.title ]
        , div [ class "details" ] [ text experience.date ]
        , ul [] (List.map viewExperienceTask experience.tasks)
        ]


viewExperienceTask : Task -> Html Msg
viewExperienceTask task =
    li [] [ text task.summary ]


viewEducation : Education -> Html Msg
viewEducation education =
    div [ class "page row" ]
        [ h2 [] [ text "Education" ]
        , h3 [] [ text education.school ]
        , div [ class "subheader" ] [ text education.graduation ]
        , div [] [ text education.degree ]
        , div [] [ text ("Minor: " ++ education.minor) ]
        , div [] [ text ("GPA: " ++ String.fromFloat education.gpa) ]
        , div [] [ text "Dean's List" ]
        ]


technicalSkills : Model -> Html Msg
technicalSkills model =
    div [ class "page row" ]
        [ h2 [] [ text "Technical Skills" ]
        , div [] [ text <| "Languages: " ++ String.join ", " model.skills.csLanguages ]
        , div [] [ text <| "Other: " ++ String.join ", " model.skills.other ]
        ]


contact : Model -> Html Msg
contact model =
    div [ class "page row" ]
        [ h2 [] [ text "Contact" ]
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
    div []
        [ button [ class "button", Event.onClick LeftTitle ] [ leftArrow model ]
        , text " . . . "
        , button [ class "button", Event.onClick RightTitle ] [ rightArrow model ]
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
