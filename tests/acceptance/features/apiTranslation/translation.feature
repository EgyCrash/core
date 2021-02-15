@api @skipOnLDAP
Feature: translate messages in api response to preferred language
  As a user
  I want response messages to be translated in preferred language
  So that I can see and understand the response messages in my language

  Scenario Outline: user tries to get non existing share and uses some preferred language
    Given user "Alice" has been created with default attributes and without skeleton files
    And these users have been created with default attributes and skeleton files:
      | username |
      | Brian    |
      | Carol    |
    And using <dav_version> DAV path
    And user "Brian" has shared file "textfile0.txt" with user "Carol"
    When user "Alice" gets the info of the last share in language "<language>" using the sharing API
    Then the OCS status code should be "404"
    And the OCS status message should be "<error_message>"
    Examples:
      | dav_version | language | error_message                                                                |
      | old         | de-DE    | Fehlerhafte Freigabe-ID, Freigabe existiert nicht                            |
      | new         | de-DE    | Fehlerhafte Freigabe-ID, Freigabe existiert nicht                            |
      | old         | zh-CN    | 错误的共享 ID，共享不存在                                                               |
      | new         | zh-CN    | 错误的共享 ID，共享不存在                                                               |
      | old         | fr-FR    | Mauvais ID de partage, le partage n'existe pas                               |
      | new         | fr-FR    | Mauvais ID de partage, le partage n'existe pas                               |
      | old         | es-ES    | El ID del recurso compartido no es correcto, el recurso compartido no existe |
      | new         | es-ES    | El ID del recurso compartido no es correcto, el recurso compartido no existe |
