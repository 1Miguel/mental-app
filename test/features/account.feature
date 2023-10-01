Feature: Account Feature

Scenario Outline: Creating an Account
    Given User account is not registered
     When User creates account
     Then Server must return response HTTP_200_OK

    Examples: Account
        | username | password     |
        | john.doe | testpassword |

Scenario Outline: User Log in
    Given User account is already registered
     When User log in
     Then Server must return response HTTP_200_OK

    Examples: Account
        | username | password     |
        | john.doe | testpassword |