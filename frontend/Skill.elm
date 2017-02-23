module Skill exposing (..)

import Html as H
import Html.Attributes as A
import Html.Events as E

type SkillLevel = Interested | Beginner | There | Experienced | Pro

type alias Model =
  { heading : String
  , skillLevel : SkillLevel
  }

allSkills : List SkillLevel
allSkills = [ Interested, Beginner, There, Experienced, Pro ]

update : SkillLevel -> Model -> Model
update skillLevel model =
  { model | skillLevel = skillLevel }

view : Bool -> Model -> H.Html SkillLevel
view editing model =
  let
    skillText =
      case model.skillLevel of
        Interested -> "Kiinnostunut"
        Beginner -> "Aloittelija"
        There -> "Alalla"
        Experienced -> "Kokenut"
        Pro -> "Konkari"

    skillNumber =
      case model.skillLevel of
        Interested -> 1
        Beginner -> 2
        There -> 3
        Experienced -> 4
        Pro -> 5

    circle type_ skillLevel =
      H.span
        [ A.class <| "skill__circle-container skill__circle-container--" ++ type_
        ]
        [ H.span
            ([ A.class <|
                 (if editing then "skill__circle--clickable " else "") ++
                 "skill__circle skill__circle--" ++ type_
             ]++ if editing then [ E.onClick skillLevel ] else [])
            []
        ]
    filledCircle = circle "filled"
    activeCircle = circle "active"
    unFilledCircle = circle "unfilled"

  in
    H.div
      []
      [ H.p
          []
          [ H.span [ A.class "skill__heading" ] [ H.text model.heading ]
          , H.span [ A.class "skill__level-text" ] [ H.text skillText ]
          ]
      , H.p
        []
        [ H.input
            [ A.value (toString skillNumber)
            , A.type_ "text"
            , A.class "skill__input"
            ] []
        , H.span [] <|
          (List.take (skillNumber - 1) allSkills |> List.map filledCircle) ++
            (List.drop (skillNumber - 1) allSkills |> List.take 1 |> List.map activeCircle) ++
              (List.drop skillNumber allSkills |> List.map unFilledCircle)

        ]
      ]
