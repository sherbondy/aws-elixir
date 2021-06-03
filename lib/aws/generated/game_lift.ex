# WARNING: DO NOT EDIT, AUTO-GENERATED CODE!
# See https://github.com/aws-beam/aws-codegen for more details.

defmodule AWS.GameLift do
  @moduledoc """
  Amazon GameLift Service

  GameLift provides solutions for hosting session-based multiplayer game servers
  in the cloud, including tools for deploying, operating, and scaling game
  servers.

  Built on AWS global computing infrastructure, GameLift helps you deliver
  high-performance, high-reliability, low-cost game servers while dynamically
  scaling your resource usage to meet player demand.

  ## About GameLift solutions

  Get more information on these GameLift solutions in the [GameLift Developer Guide](https://docs.aws.amazon.com/gamelift/latest/developerguide/).

    * GameLift managed hosting -- GameLift offers a fully managed
  service to set up and maintain computing machines for hosting, manage game
  session and player session life cycle, and handle security, storage, and
  performance tracking. You can use automatic scaling tools to balance player
  demand and hosting costs, configure your game session management to minimize
  player latency, and add FlexMatch for matchmaking.

    * Managed hosting with Realtime Servers -- With GameLift Realtime
  Servers, you can quickly configure and set up ready-to-go game servers for your
  game. Realtime Servers provides a game server framework with core GameLift
  infrastructure already built in. Then use the full range of GameLift managed
  hosting features, including FlexMatch, for your game.

    * GameLift FleetIQ -- Use GameLift FleetIQ as a standalone service
  while hosting your games using EC2 instances and Auto Scaling groups. GameLift
  FleetIQ provides optimizations for game hosting, including boosting the
  viability of low-cost Spot Instances gaming. For a complete solution, pair the
  GameLift FleetIQ and FlexMatch standalone services.

    * GameLift FlexMatch -- Add matchmaking to your game hosting
  solution. FlexMatch is a customizable matchmaking service for multiplayer games.
  Use FlexMatch as integrated with GameLift managed hosting or incorporate
  FlexMatch as a standalone service into your own hosting solution.

  ## About this API Reference

  This reference guide describes the low-level service API for Amazon GameLift.
  With each topic in this guide, you can find links to language-specific SDK
  guides and the AWS CLI reference. Useful links:

    * [GameLift API operations listed by tasks](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html)

    * [ GameLift tools and resources](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-components.html)
  """

  alias AWS.Client
  alias AWS.Request

  def metadata do
    %AWS.ServiceMetadata{
      abbreviation: nil,
      api_version: "2015-10-01",
      content_type: "application/x-amz-json-1.1",
      credential_scope: nil,
      endpoint_prefix: "gamelift",
      global?: false,
      protocol: "json",
      service_id: "GameLift",
      signature_version: "v4",
      signing_name: "gamelift",
      target_prefix: "GameLift"
    }
  end

  @doc """
  Registers a player's acceptance or rejection of a proposed FlexMatch match.

  A matchmaking configuration may require player acceptance; if so, then matches
  built with that configuration cannot be completed unless all players accept the
  proposed match within a specified time limit.

  When FlexMatch builds a match, all the matchmaking tickets involved in the
  proposed match are placed into status `REQUIRES_ACCEPTANCE`. This is a trigger
  for your game to get acceptance from all players in the ticket. Acceptances are
  only valid for tickets when they are in this status; all other acceptances
  result in an error.

  To register acceptance, specify the ticket ID, a response, and one or more
  players. Once all players have registered acceptance, the matchmaking tickets
  advance to status `PLACING`, where a new game session is created for the match.

  If any player rejects the match, or if acceptances are not received before a
  specified timeout, the proposed match is dropped. The matchmaking tickets are
  then handled in one of two ways: For tickets where one or more players rejected
  the match, the ticket status is returned to `SEARCHING` to find a new match. For
  tickets where one or more players failed to respond, the ticket status is set to
  `CANCELLED`, and processing is terminated. A new matchmaking request for these
  players can be submitted as needed.

  ## Learn more

  [ Add FlexMatch to a game client](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/match-client.html)

  [ FlexMatch events](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/match-events.html)
  (reference)

  ## Related actions

  `StartMatchmaking` | `DescribeMatchmaking` | `StopMatchmaking` | `AcceptMatch` |
  `StartMatchBackfill` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def accept_match(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "AcceptMatch", input, options)
  end

  @doc """
  ## This operation is used with the GameLift FleetIQ solution and game server
  groups.

  Locates an available game server and temporarily reserves it to host gameplay
  and players.

  This operation is called from a game client or client service (such as a
  matchmaker) to request hosting resources for a new game session. In response,
  GameLift FleetIQ locates an available game server, places it in `CLAIMED` status
  for 60 seconds, and returns connection information that players can use to
  connect to the game server.

  To claim a game server, identify a game server group. You can also specify a
  game server ID, although this approach bypasses GameLift FleetIQ placement
  optimization. Optionally, include game data to pass to the game server at the
  start of a game session, such as a game map or player information.

  When a game server is successfully claimed, connection information is returned.
  A claimed game server's utilization status remains `AVAILABLE` while the claim
  status is set to `CLAIMED` for up to 60 seconds. This time period gives the game
  server time to update its status to `UTILIZED` (using `UpdateGameServer`) once
  players join. If the game server's status is not updated within 60 seconds, the
  game server reverts to unclaimed status and is available to be claimed by
  another request. The claim time period is a fixed value and is not configurable.

  If you try to claim a specific game server, this request will fail in the
  following cases:

    * If the game server utilization status is `UTILIZED`.

    * If the game server claim status is `CLAIMED`.

  When claiming a specific game server, this request will succeed even if the game
  server is running on an instance in `DRAINING` status. To avoid this, first
  check the instance status by calling `DescribeGameServerInstances`.

  ## Learn more

  [GameLift FleetIQ Guide](https://docs.aws.amazon.com/gamelift/latest/fleetiqguide/gsg-intro.html)

  ## Related actions

  `RegisterGameServer` | `ListGameServers` | `ClaimGameServer` |
  `DescribeGameServer` | `UpdateGameServer` | `DeregisterGameServer` | [All APIs by
  task](https://docs.aws.amazon.com/gamelift/latest/fleetiqguide/reference-awssdk-fleetiq.html)
  """
  def claim_game_server(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "ClaimGameServer", input, options)
  end

  @doc """
  Creates an alias for a fleet.

  In most situations, you can use an alias ID in place of a fleet ID. An alias
  provides a level of abstraction for a fleet that is useful when redirecting
  player traffic from one fleet to another, such as when updating your game build.

  Amazon GameLift supports two types of routing strategies for aliases: simple and
  terminal. A simple alias points to an active fleet. A terminal alias is used to
  display messaging or link to a URL instead of routing players to an active
  fleet. For example, you might use a terminal alias when a game version is no
  longer supported and you want to direct players to an upgrade site.

  To create a fleet alias, specify an alias name, routing strategy, and optional
  description. Each simple alias can point to only one fleet, but a fleet can have
  multiple aliases. If successful, a new alias record is returned, including an
  alias ID and an ARN. You can reassign an alias to another fleet by calling
  `UpdateAlias`.

  ## Related actions

  `CreateAlias` | `ListAliases` | `DescribeAlias` | `UpdateAlias` | `DeleteAlias`
  | `ResolveAlias` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def create_alias(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "CreateAlias", input, options)
  end

  @doc """
  Creates a new Amazon GameLift build resource for your game server binary files.

  Game server binaries must be combined into a zip file for use with Amazon
  GameLift.

  When setting up a new game build for GameLift, we recommend using the AWS CLI
  command **
  [upload-build](https://docs.aws.amazon.com/cli/latest/reference/gamelift/upload-build.html) **. This helper command combines two tasks: (1) it uploads your build files from
  a file directory to a GameLift Amazon S3 location, and (2) it creates a new
  build resource.

  The `CreateBuild` operation can used in the following scenarios:

    * To create a new game build with build files that are in an Amazon
  S3 location under an AWS account that you control. To use this option, you must
  first give Amazon GameLift access to the Amazon S3 bucket. With permissions in
  place, call `CreateBuild` and specify a build name, operating system, and the
  Amazon S3 storage location of your game build.

    * To directly upload your build files to a GameLift Amazon S3
  location. To use this option, first call `CreateBuild` and specify a build name
  and operating system. This operation creates a new build resource and also
  returns an Amazon S3 location with temporary access credentials. Use the
  credentials to manually upload your build files to the specified Amazon S3
  location. For more information, see [Uploading
  Objects](https://docs.aws.amazon.com/AmazonS3/latest/dev/UploadingObjects.html)
  in the *Amazon S3 Developer Guide*. Build files can be uploaded to the GameLift
  Amazon S3 location once only; that can't be updated.

  If successful, this operation creates a new build resource with a unique build
  ID and places it in `INITIALIZED` status. A build must be in `READY` status
  before you can create fleets with it.

  ## Learn more

  [Uploading Your Game](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-build-intro.html)

  [ Create a Build with Files in Amazon S3](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-build-cli-uploading.html#gamelift-build-cli-uploading-create-build)

  ## Related actions

  `CreateBuild` | `ListBuilds` | `DescribeBuild` | `UpdateBuild` | `DeleteBuild` |
  [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def create_build(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "CreateBuild", input, options)
  end

  @doc """
  Creates a fleet of Amazon Elastic Compute Cloud (Amazon EC2) instances to host
  your custom game server or Realtime Servers.

  Use this operation to configure the computing resources for your fleet and
  provide instructions for running game servers on each instance.

  Most GameLift fleets can deploy instances to multiple locations, including the
  home Region (where the fleet is created) and an optional set of remote
  locations. Fleets that are created in the following AWS Regions support multiple
  locations: us-east-1 (N. Virginia), us-west-2 (Oregon), eu-central-1
  (Frankfurt), eu-west-1 (Ireland), ap-southeast-2 (Sydney), ap-northeast-1
  (Tokyo), and ap-northeast-2 (Seoul). Fleets that are created in other GameLift
  Regions can deploy instances in the fleet's home Region only. All fleet
  instances use the same configuration regardless of location; however, you can
  adjust capacity settings and turn auto-scaling on/off for each location.

  To create a fleet, choose the hardware for your instances, specify a game server
  build or Realtime script to deploy, and provide a runtime configuration to
  direct GameLift how to start and run game servers on each instance in the fleet.
  Set permissions for inbound traffic to your game servers, and enable optional
  features as needed. When creating a multi-location fleet, provide a list of
  additional remote locations.

  If successful, this operation creates a new Fleet resource and places it in
  `NEW` status, which prompts GameLift to initiate the [fleet creation workflow](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-creation-workflow.html).
  You can track fleet creation by checking fleet status using
  `DescribeFleetAttributes` and `DescribeFleetLocationAttributes`/, or by
  monitoring fleet creation events using `DescribeFleetEvents`. As soon as the
  fleet status changes to `ACTIVE`, you can enable automatic scaling for the fleet
  with `PutScalingPolicy` and set capacity for the home Region with
  `UpdateFleetCapacity`. When the status of each remote location reaches `ACTIVE`,
  you can set capacity by location using `UpdateFleetCapacity`.

  ## Learn more

  [Setting up fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-intro.html)

  [Debug fleet creation issues](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-creating-debug.html#fleets-creating-debug-creation)

  [Multi-location fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-intro.html)

  ## Related actions

  `CreateFleet` | `UpdateFleetCapacity` | `PutScalingPolicy` |
  `DescribeEC2InstanceLimits` | `DescribeFleetAttributes` |
  `DescribeFleetLocationAttributes` | `UpdateFleetAttributes` | `StopFleetActions`
  | `DeleteFleet` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def create_fleet(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "CreateFleet", input, options)
  end

  @doc """
  Adds remote locations to a fleet and begins populating the new locations with
  EC2 instances.

  The new instances conform to the fleet's instance type, auto-scaling, and other
  configuration settings.

  This operation cannot be used with fleets that don't support remote locations.
  Fleets can have multiple locations only if they reside in AWS Regions that
  support this feature (see `CreateFleet` for the complete list) and were created
  after the feature was released in March 2021.

  To add fleet locations, specify the fleet to be updated and provide a list of
  one or more locations.

  If successful, this operation returns the list of added locations with their
  status set to `NEW`. GameLift initiates the process of starting an instance in
  each added location. You can track the status of each new location by monitoring
  location creation events using `DescribeFleetEvents`. Alternatively, you can
  poll location status by calling `DescribeFleetLocationAttributes`. After a
  location status becomes `ACTIVE`, you can adjust the location's capacity as
  needed with `UpdateFleetCapacity`.

  ## Learn more

  [Setting up fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-intro.html)

  [Multi-location fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-intro.html)

  ## Related actions

  `CreateFleetLocations` | `DescribeFleetLocationAttributes` |
  `DescribeFleetLocationCapacity` | `DescribeFleetLocationUtilization` |
  `DescribeFleetAttributes` | `DescribeFleetCapacity` | `DescribeFleetUtilization`
  | `UpdateFleetCapacity` | `StopFleetActions` | `DeleteFleetLocations` | [All APIs by
  task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def create_fleet_locations(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "CreateFleetLocations", input, options)
  end

  @doc """
  ## This operation is used with the GameLift FleetIQ solution and game server
  groups.

  Creates a GameLift FleetIQ game server group for managing game hosting on a
  collection of Amazon EC2 instances for game hosting.

  This operation creates the game server group, creates an Auto Scaling group in
  your AWS account, and establishes a link between the two groups. You can view
  the status of your game server groups in the GameLift console. Game server group
  metrics and events are emitted to Amazon CloudWatch.

  Before creating a new game server group, you must have the following:

    * An Amazon EC2 launch template that specifies how to launch Amazon
  EC2 instances with your game server build. For more information, see [ Launching an Instance from a Launch
  Template](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-launch-templates.html)
  in the *Amazon EC2 User Guide*.

    * An IAM role that extends limited access to your AWS account to
  allow GameLift FleetIQ to create and interact with the Auto Scaling group. For
  more information, see [Create IAM roles for cross-service interaction](https://docs.aws.amazon.com/gamelift/latest/fleetiqguide/gsg-iam-permissions-roles.html)
  in the *GameLift FleetIQ Developer Guide*.

  To create a new game server group, specify a unique group name, IAM role and
  Amazon EC2 launch template, and provide a list of instance types that can be
  used in the group. You must also set initial maximum and minimum limits on the
  group's instance count. You can optionally set an Auto Scaling policy with
  target tracking based on a GameLift FleetIQ metric.

  Once the game server group and corresponding Auto Scaling group are created, you
  have full access to change the Auto Scaling group's configuration as needed.
  Several properties that are set when creating a game server group, including
  maximum/minimum size and auto-scaling policy settings, must be updated directly
  in the Auto Scaling group. Keep in mind that some Auto Scaling group properties
  are periodically updated by GameLift FleetIQ as part of its balancing activities
  to optimize for availability and cost.

  ## Learn more

  [GameLift FleetIQ Guide](https://docs.aws.amazon.com/gamelift/latest/fleetiqguide/gsg-intro.html)

  ## Related actions

  `CreateGameServerGroup` | `ListGameServerGroups` | `DescribeGameServerGroup` |
  `UpdateGameServerGroup` | `DeleteGameServerGroup` | `ResumeGameServerGroup` |
  `SuspendGameServerGroup` | `DescribeGameServerInstances` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/fleetiqguide/reference-awssdk-fleetiq.html)
  """
  def create_game_server_group(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "CreateGameServerGroup", input, options)
  end

  @doc """
  Creates a multiplayer game session for players in a specific fleet location.

  This operation prompts an available server process to start a game session and
  retrieves connection information for the new game session. As an alternative,
  consider using the GameLift game session placement feature with

  with `StartGameSessionPlacement`, which uses FleetIQ algorithms and queues to
  optimize the placement process.

  When creating a game session, you specify exactly where you want to place it and
  provide a set of game session configuration settings. The fleet must be in
  `ACTIVE` status before a game session can be created in it.

  This operation can be used in the following ways:

    * To create a game session on an instance in a fleet's home Region,
  provide a fleet or alias ID along with your game session configuration.

    * To create a game session on an instance in a fleet's remote
  location, provide a fleet or alias ID and a location name, along with your game
  session configuration.

  If successful, a workflow is initiated to start a new game session. A
  `GameSession` object is returned containing the game session configuration and
  status. When the status is `ACTIVE`, game session connection information is
  provided and player sessions can be created for the game session. By default,
  newly created game sessions are open to new players. You can restrict new player
  access by using `UpdateGameSession` to change the game session's player session
  creation policy.

  Game session logs are retained for all active game sessions for 14 days. To
  access the logs, call `GetGameSessionLogUrl` to download the log files.

  *Available in GameLift Local.*

  ## Learn more

  [Start a game session](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-sdk-server-api.html#gamelift-sdk-server-startsession)

  ## Related actions

  `CreateGameSession` | `DescribeGameSessions` | `DescribeGameSessionDetails` |
  `SearchGameSessions` | `UpdateGameSession` | `GetGameSessionLogUrl` |
  `StartGameSessionPlacement` | `DescribeGameSessionPlacement` |
  `StopGameSessionPlacement` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def create_game_session(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "CreateGameSession", input, options)
  end

  @doc """
  Creates a placement queue that processes requests for new game sessions.

  A queue uses FleetIQ algorithms to determine the best placement locations and
  find an available game server there, then prompts the game server process to
  start a new game session.

  A game session queue is configured with a set of destinations (GameLift fleets
  or aliases), which determine the locations where the queue can place new game
  sessions. These destinations can span multiple fleet types (Spot and On-Demand),
  instance types, and AWS Regions. If the queue includes multi-location fleets,
  the queue is able to place game sessions in all of a fleet's remote locations.
  You can opt to filter out individual locations if needed.

  The queue configuration also determines how FleetIQ selects the best available
  placement for a new game session. Before searching for an available game server,
  FleetIQ first prioritizes the queue's destinations and locations, with the best
  placement locations on top. You can set up the queue to use the FleetIQ default
  prioritization or provide an alternate set of priorities.

  To create a new queue, provide a name, timeout value, and a list of
  destinations. Optionally, specify a sort configuration and/or a filter, and
  define a set of latency cap policies. You can also include the ARN for an Amazon
  Simple Notification Service (SNS) topic to receive notifications of game session
  placement activity. Notifications using SNS or CloudWatch events is the
  preferred way to track placement activity.

  If successful, a new `GameSessionQueue` object is returned with an assigned
  queue ARN. New game session requests, which are submitted to the queue with
  `StartGameSessionPlacement` or `StartMatchmaking`, reference a queue's name or
  ARN.

  ## Learn more

  [ Design a game session queue](https://docs.aws.amazon.com/gamelift/latest/developerguide/queues-design.html)

  [ Create a game session queue](https://docs.aws.amazon.com/gamelift/latest/developerguide/queues-creating.html)

  ## Related actions

  `CreateGameSessionQueue` | `DescribeGameSessionQueues` |
  `UpdateGameSessionQueue` | `DeleteGameSessionQueue` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def create_game_session_queue(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "CreateGameSessionQueue", input, options)
  end

  @doc """
  Defines a new matchmaking configuration for use with FlexMatch.

  Whether your are using FlexMatch with GameLift hosting or as a standalone
  matchmaking service, the matchmaking configuration sets out rules for matching
  players and forming teams. If you're also using GameLift hosting, it defines how
  to start game sessions for each match. Your matchmaking system can use multiple
  configurations to handle different game scenarios. All matchmaking requests
  (`StartMatchmaking` or `StartMatchBackfill`) identify the matchmaking
  configuration to use and provide player attributes consistent with that
  configuration.

  To create a matchmaking configuration, you must provide the following:
  configuration name and FlexMatch mode (with or without GameLift hosting); a rule
  set that specifies how to evaluate players and find acceptable matches; whether
  player acceptance is required; and the maximum time allowed for a matchmaking
  attempt. When using FlexMatch with GameLift hosting, you also need to identify
  the game session queue to use when starting a game session for the match.

  In addition, you must set up an Amazon Simple Notification Service (SNS) topic
  to receive matchmaking notifications. Provide the topic ARN in the matchmaking
  configuration. An alternative method, continuously polling ticket status with
  `DescribeMatchmaking`, is only suitable for games in development with low
  matchmaking usage.

  ## Learn more

  [ Design a FlexMatch matchmaker](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/match-configuration.html)

  [ Set up FlexMatch event notification](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/match-notification.html)

  ## Related actions

  `CreateMatchmakingConfiguration` | `DescribeMatchmakingConfigurations` |
  `UpdateMatchmakingConfiguration` | `DeleteMatchmakingConfiguration` |
  `CreateMatchmakingRuleSet` | `DescribeMatchmakingRuleSets` |
  `ValidateMatchmakingRuleSet` | `DeleteMatchmakingRuleSet` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def create_matchmaking_configuration(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "CreateMatchmakingConfiguration", input, options)
  end

  @doc """
  Creates a new rule set for FlexMatch matchmaking.

  A rule set describes the type of match to create, such as the number and size of
  teams. It also sets the parameters for acceptable player matches, such as
  minimum skill level or character type. A rule set is used by a
  `MatchmakingConfiguration`.

  To create a matchmaking rule set, provide unique rule set name and the rule set
  body in JSON format. Rule sets must be defined in the same Region as the
  matchmaking configuration they are used with.

  Since matchmaking rule sets cannot be edited, it is a good idea to check the
  rule set syntax using `ValidateMatchmakingRuleSet` before creating a new rule
  set.

  ## Learn more

    * [Build a rule set](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/match-rulesets.html)

    * [Design a matchmaker](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/match-configuration.html)

    * [Matchmaking with FlexMatch](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/match-intro.html)

  ## Related actions

  `CreateMatchmakingConfiguration` | `DescribeMatchmakingConfigurations` |
  `UpdateMatchmakingConfiguration` | `DeleteMatchmakingConfiguration` |
  `CreateMatchmakingRuleSet` | `DescribeMatchmakingRuleSets` |
  `ValidateMatchmakingRuleSet` | `DeleteMatchmakingRuleSet` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def create_matchmaking_rule_set(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "CreateMatchmakingRuleSet", input, options)
  end

  @doc """
  Reserves an open player slot in a game session for a player.

  New player sessions can be created in any game session with an open slot that is
  in `ACTIVE` status and has a player creation policy of `ACCEPT_ALL`. You can add
  a group of players to a game session with `CreatePlayerSessions`.

  To create a player session, specify a game session ID, player ID, and optionally
  a set of player data.

  If successful, a slot is reserved in the game session for the player and a new
  `PlayerSession` object is returned with a player session ID. The player
  references the player session ID when sending a connection request to the game
  session, and the game server can use it to validate the player reservation with
  the GameLift service. Player sessions cannot be updated.

  *Available in Amazon GameLift Local.*

  ## Related actions

  `CreatePlayerSession` | `CreatePlayerSessions` | `DescribePlayerSessions` |
  `StartGameSessionPlacement` | `DescribeGameSessionPlacement` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def create_player_session(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "CreatePlayerSession", input, options)
  end

  @doc """
  Reserves open slots in a game session for a group of players.

  New player sessions can be created in any game session with an open slot that is
  in `ACTIVE` status and has a player creation policy of `ACCEPT_ALL`. To add a
  single player to a game session, use `CreatePlayerSession`.

  To create player sessions, specify a game session ID and a list of player IDs.
  Optionally, provide a set of player data for each player ID.

  If successful, a slot is reserved in the game session for each player, and new
  `PlayerSession` objects are returned with player session IDs. Each player
  references their player session ID when sending a connection request to the game
  session, and the game server can use it to validate the player reservation with
  the GameLift service. Player sessions cannot be updated.

  *Available in Amazon GameLift Local.*

  ## Related actions

  `CreatePlayerSession` | `CreatePlayerSessions` | `DescribePlayerSessions` |
  `StartGameSessionPlacement` | `DescribeGameSessionPlacement` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def create_player_sessions(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "CreatePlayerSessions", input, options)
  end

  @doc """
  Creates a new script record for your Realtime Servers script.

  Realtime scripts are JavaScript that provide configuration settings and optional
  custom game logic for your game. The script is deployed when you create a
  Realtime Servers fleet to host your game sessions. Script logic is executed
  during an active game session.

  To create a new script record, specify a script name and provide the script
  file(s). The script files and all dependencies must be zipped into a single
  file. You can pull the zip file from either of these locations:

    * A locally available directory. Use the *ZipFile* parameter for
  this option.

    * An Amazon Simple Storage Service (Amazon S3) bucket under your AWS
  account. Use the *StorageLocation* parameter for this option. You'll need to
  have an Identity Access Management (IAM) role that allows the Amazon GameLift
  service to access your S3 bucket.

  If the call is successful, a new script record is created with a unique script
  ID. If the script file is provided as a local file, the file is uploaded to an
  Amazon GameLift-owned S3 bucket and the script record's storage location
  reflects this location. If the script file is provided as an S3 bucket, Amazon
  GameLift accesses the file at this storage location as needed for deployment.

  ## Learn more

  [Amazon GameLift Realtime Servers](https://docs.aws.amazon.com/gamelift/latest/developerguide/realtime-intro.html)

  [Set Up a Role for Amazon GameLift Access](https://docs.aws.amazon.com/gamelift/latest/developerguide/setting-up-role.html)

  ## Related actions

  `CreateScript` | `ListScripts` | `DescribeScript` | `UpdateScript` |
  `DeleteScript` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def create_script(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "CreateScript", input, options)
  end

  @doc """
  Requests authorization to create or delete a peer connection between the VPC for
  your Amazon GameLift fleet and a virtual private cloud (VPC) in your AWS
  account.

  VPC peering enables the game servers on your fleet to communicate directly with
  other AWS resources. Once you've received authorization, call
  `CreateVpcPeeringConnection` to establish the peering connection. For more
  information, see [VPC Peering with Amazon GameLift Fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/vpc-peering.html).

  You can peer with VPCs that are owned by any AWS account you have access to,
  including the account that you use to manage your Amazon GameLift fleets. You
  cannot peer with VPCs that are in different Regions.

  To request authorization to create a connection, call this operation from the
  AWS account with the VPC that you want to peer to your Amazon GameLift fleet.
  For example, to enable your game servers to retrieve data from a DynamoDB table,
  use the account that manages that DynamoDB resource. Identify the following
  values: (1) The ID of the VPC that you want to peer with, and (2) the ID of the
  AWS account that you use to manage Amazon GameLift. If successful, VPC peering
  is authorized for the specified VPC.

  To request authorization to delete a connection, call this operation from the
  AWS account with the VPC that is peered with your Amazon GameLift fleet.
  Identify the following values: (1) VPC ID that you want to delete the peering
  connection for, and (2) ID of the AWS account that you use to manage Amazon
  GameLift.

  The authorization remains valid for 24 hours unless it is canceled by a call to
  `DeleteVpcPeeringAuthorization`. You must create or delete the peering
  connection while the authorization is valid.

  ## Related actions

  `CreateVpcPeeringAuthorization` | `DescribeVpcPeeringAuthorizations` |
  `DeleteVpcPeeringAuthorization` | `CreateVpcPeeringConnection` |
  `DescribeVpcPeeringConnections` | `DeleteVpcPeeringConnection` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def create_vpc_peering_authorization(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "CreateVpcPeeringAuthorization", input, options)
  end

  @doc """
  Establishes a VPC peering connection between a virtual private cloud (VPC) in an
  AWS account with the VPC for your Amazon GameLift fleet.

  VPC peering enables the game servers on your fleet to communicate directly with
  other AWS resources. You can peer with VPCs in any AWS account that you have
  access to, including the account that you use to manage your Amazon GameLift
  fleets. You cannot peer with VPCs that are in different Regions. For more
  information, see [VPC Peering with Amazon GameLift Fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/vpc-peering.html).

  Before calling this operation to establish the peering connection, you first
  need to call `CreateVpcPeeringAuthorization` and identify the VPC you want to
  peer with. Once the authorization for the specified VPC is issued, you have 24
  hours to establish the connection. These two operations handle all tasks
  necessary to peer the two VPCs, including acceptance, updating routing tables,
  etc.

  To establish the connection, call this operation from the AWS account that is
  used to manage the Amazon GameLift fleets. Identify the following values: (1)
  The ID of the fleet you want to be enable a VPC peering connection for; (2) The
  AWS account with the VPC that you want to peer with; and (3) The ID of the VPC
  you want to peer with. This operation is asynchronous. If successful, a
  `VpcPeeringConnection` request is created. You can use continuous polling to
  track the request's status using `DescribeVpcPeeringConnections`, or by
  monitoring fleet events for success or failure using `DescribeFleetEvents`.

  ## Related actions

  `CreateVpcPeeringAuthorization` | `DescribeVpcPeeringAuthorizations` |
  `DeleteVpcPeeringAuthorization` | `CreateVpcPeeringConnection` |
  `DescribeVpcPeeringConnections` | `DeleteVpcPeeringConnection` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def create_vpc_peering_connection(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "CreateVpcPeeringConnection", input, options)
  end

  @doc """
  Deletes an alias.

  This operation removes all record of the alias. Game clients attempting to
  access a server process using the deleted alias receive an error. To delete an
  alias, specify the alias ID to be deleted.

  ## Related actions

  `CreateAlias` | `ListAliases` | `DescribeAlias` | `UpdateAlias` | `DeleteAlias`
  | `ResolveAlias` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def delete_alias(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DeleteAlias", input, options)
  end

  @doc """
  Deletes a build.

  This operation permanently deletes the build resource and any uploaded build
  files. Deleting a build does not affect the status of any active fleets using
  the build, but you can no longer create new fleets with the deleted build.

  To delete a build, specify the build ID.

  ## Learn more

  [ Upload a Custom Server Build](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-build-intro.html)

  ## Related actions

  `CreateBuild` | `ListBuilds` | `DescribeBuild` | `UpdateBuild` | `DeleteBuild` |
  [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def delete_build(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DeleteBuild", input, options)
  end

  @doc """
  Deletes all resources and information related a fleet.

  Any current fleet instances, including those in remote locations, are shut down.
  You don't need to call `DeleteFleetLocations` separately.

  If the fleet being deleted has a VPC peering connection, you first need to get a
  valid authorization (good for 24 hours) by calling
  `CreateVpcPeeringAuthorization`. You do not need to explicitly delete the VPC
  peering connection--this is done as part of the delete fleet process.

  To delete a fleet, specify the fleet ID to be terminated. During the deletion
  process the fleet status is changed to `DELETING`. When completed, the status
  switches to `TERMINATED` and the fleet event `FLEET_DELETED` is sent.

  ## Learn more

  [Setting up GameLift Fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-intro.html)

  ## Related actions

  `CreateFleetLocations` | `UpdateFleetAttributes` | `UpdateFleetCapacity` |
  `UpdateFleetPortSettings` | `UpdateRuntimeConfiguration` | `StopFleetActions` |
  `StartFleetActions` | `PutScalingPolicy` | `DeleteFleet` |
  `DeleteFleetLocations` | `DeleteScalingPolicy` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def delete_fleet(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DeleteFleet", input, options)
  end

  @doc """
  Removes locations from a multi-location fleet.

  When deleting a location, all game server process and all instances that are
  still active in the location are shut down.

  To delete fleet locations, identify the fleet ID and provide a list of the
  locations to be deleted.

  If successful, GameLift sets the location status to `DELETING`, and begins to
  shut down existing server processes and terminate instances in each location
  being deleted. When completed, the location status changes to `TERMINATED`.

  ## Learn more

  [Setting up GameLift fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-intro.html)

  ## Related actions

  `CreateFleetLocations` | `DescribeFleetLocationAttributes` |
  `DescribeFleetLocationCapacity` | `DescribeFleetLocationUtilization` |
  `DescribeFleetAttributes` | `DescribeFleetCapacity` | `DescribeFleetUtilization`
  | `UpdateFleetCapacity` | `StopFleetActions` | `DeleteFleetLocations` | [All APIs by
  task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def delete_fleet_locations(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DeleteFleetLocations", input, options)
  end

  @doc """
  ## This operation is used with the GameLift FleetIQ solution and game server
  groups.

  Terminates a game server group and permanently deletes the game server group
  record.

  You have several options for how these resources are impacted when deleting the
  game server group. Depending on the type of delete operation selected, this
  operation might affect these resources:

    * The game server group

    * The corresponding Auto Scaling group

    * All game servers that are currently running in the group

  To delete a game server group, identify the game server group to delete and
  specify the type of delete operation to initiate. Game server groups can only be
  deleted if they are in `ACTIVE` or `ERROR` status.

  If the delete request is successful, a series of operations are kicked off. The
  game server group status is changed to `DELETE_SCHEDULED`, which prevents new
  game servers from being registered and stops automatic scaling activity. Once
  all game servers in the game server group are deregistered, GameLift FleetIQ can
  begin deleting resources. If any of the delete operations fail, the game server
  group is placed in `ERROR` status.

  GameLift FleetIQ emits delete events to Amazon CloudWatch.

  ## Learn more

  [GameLift FleetIQ Guide](https://docs.aws.amazon.com/gamelift/latest/fleetiqguide/gsg-intro.html)

  ## Related actions

  `CreateGameServerGroup` | `ListGameServerGroups` | `DescribeGameServerGroup` |
  `UpdateGameServerGroup` | `DeleteGameServerGroup` | `ResumeGameServerGroup` |
  `SuspendGameServerGroup` | `DescribeGameServerInstances` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/fleetiqguide/reference-awssdk-fleetiq.html)
  """
  def delete_game_server_group(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DeleteGameServerGroup", input, options)
  end

  @doc """
  Deletes a game session queue.

  Once a queue is successfully deleted, unfulfilled `StartGameSessionPlacement`
  requests that reference the queue will fail. To delete a queue, specify the
  queue name.

  ## Learn more

  [ Using Multi-Region Queues](https://docs.aws.amazon.com/gamelift/latest/developerguide/queues-intro.html)

  ## Related actions

  `CreateGameSessionQueue` | `DescribeGameSessionQueues` |
  `UpdateGameSessionQueue` | `DeleteGameSessionQueue` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def delete_game_session_queue(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DeleteGameSessionQueue", input, options)
  end

  @doc """
  Permanently removes a FlexMatch matchmaking configuration.

  To delete, specify the configuration name. A matchmaking configuration cannot be
  deleted if it is being used in any active matchmaking tickets.

  ## Related actions

  `CreateMatchmakingConfiguration` | `DescribeMatchmakingConfigurations` |
  `UpdateMatchmakingConfiguration` | `DeleteMatchmakingConfiguration` |
  `CreateMatchmakingRuleSet` | `DescribeMatchmakingRuleSets` |
  `ValidateMatchmakingRuleSet` | `DeleteMatchmakingRuleSet` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def delete_matchmaking_configuration(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DeleteMatchmakingConfiguration", input, options)
  end

  @doc """
  Deletes an existing matchmaking rule set.

  To delete the rule set, provide the rule set name. Rule sets cannot be deleted
  if they are currently being used by a matchmaking configuration.

  ## Learn more

    * [Build a rule set](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/match-rulesets.html)

  ## Related actions

  `CreateMatchmakingConfiguration` | `DescribeMatchmakingConfigurations` |
  `UpdateMatchmakingConfiguration` | `DeleteMatchmakingConfiguration` |
  `CreateMatchmakingRuleSet` | `DescribeMatchmakingRuleSets` |
  `ValidateMatchmakingRuleSet` | `DeleteMatchmakingRuleSet` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def delete_matchmaking_rule_set(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DeleteMatchmakingRuleSet", input, options)
  end

  @doc """
  Deletes a fleet scaling policy.

  Once deleted, the policy is no longer in force and GameLift removes all record
  of it. To delete a scaling policy, specify both the scaling policy name and the
  fleet ID it is associated with.

  To temporarily suspend scaling policies, call `StopFleetActions`. This operation
  suspends all policies for the fleet.

  ## Related actions

  `DescribeFleetCapacity` | `UpdateFleetCapacity` | `DescribeEC2InstanceLimits` |
  `PutScalingPolicy` | `DescribeScalingPolicies` | `DeleteScalingPolicy` |
  `StopFleetActions` | `StartFleetActions` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def delete_scaling_policy(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DeleteScalingPolicy", input, options)
  end

  @doc """
  Deletes a Realtime script.

  This operation permanently deletes the script record. If script files were
  uploaded, they are also deleted (files stored in an S3 bucket are not deleted).

  To delete a script, specify the script ID. Before deleting a script, be sure to
  terminate all fleets that are deployed with the script being deleted. Fleet
  instances periodically check for script updates, and if the script record no
  longer exists, the instance will go into an error state and be unable to host
  game sessions.

  ## Learn more

  [Amazon GameLift Realtime Servers](https://docs.aws.amazon.com/gamelift/latest/developerguide/realtime-intro.html)

  ## Related actions

  `CreateScript` | `ListScripts` | `DescribeScript` | `UpdateScript` |
  `DeleteScript` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def delete_script(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DeleteScript", input, options)
  end

  @doc """
  Cancels a pending VPC peering authorization for the specified VPC.

  If you need to delete an existing VPC peering connection, call
  `DeleteVpcPeeringConnection`.

  ## Related actions

  `CreateVpcPeeringAuthorization` | `DescribeVpcPeeringAuthorizations` |
  `DeleteVpcPeeringAuthorization` | `CreateVpcPeeringConnection` |
  `DescribeVpcPeeringConnections` | `DeleteVpcPeeringConnection` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def delete_vpc_peering_authorization(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DeleteVpcPeeringAuthorization", input, options)
  end

  @doc """
  Removes a VPC peering connection.

  To delete the connection, you must have a valid authorization for the VPC
  peering connection that you want to delete. You can check for an authorization
  by calling `DescribeVpcPeeringAuthorizations` or request a new one using
  `CreateVpcPeeringAuthorization`.

  Once a valid authorization exists, call this operation from the AWS account that
  is used to manage the Amazon GameLift fleets. Identify the connection to delete
  by the connection ID and fleet ID. If successful, the connection is removed.

  ## Related actions

  `CreateVpcPeeringAuthorization` | `DescribeVpcPeeringAuthorizations` |
  `DeleteVpcPeeringAuthorization` | `CreateVpcPeeringConnection` |
  `DescribeVpcPeeringConnections` | `DeleteVpcPeeringConnection` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def delete_vpc_peering_connection(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DeleteVpcPeeringConnection", input, options)
  end

  @doc """
  ## This operation is used with the GameLift FleetIQ solution and game server
  groups.

  Removes the game server from a game server group.

  As a result of this operation, the deregistered game server can no longer be
  claimed and will not be returned in a list of active game servers.

  To deregister a game server, specify the game server group and game server ID.
  If successful, this operation emits a CloudWatch event with termination
  timestamp and reason.

  ## Learn more

  [GameLift FleetIQ Guide](https://docs.aws.amazon.com/gamelift/latest/fleetiqguide/gsg-intro.html)

  ## Related actions

  `RegisterGameServer` | `ListGameServers` | `ClaimGameServer` |
  `DescribeGameServer` | `UpdateGameServer` | `DeregisterGameServer` | [All APIs by
  task](https://docs.aws.amazon.com/gamelift/latest/fleetiqguide/reference-awssdk-fleetiq.html)
  """
  def deregister_game_server(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DeregisterGameServer", input, options)
  end

  @doc """
  Retrieves properties for an alias.

  This operation returns all alias metadata and settings. To get an alias's target
  fleet ID only, use `ResolveAlias`.

  To get alias properties, specify the alias ID. If successful, the requested
  alias record is returned.

  ## Related actions

  `CreateAlias` | `ListAliases` | `DescribeAlias` | `UpdateAlias` | `DeleteAlias`
  | `ResolveAlias` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def describe_alias(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeAlias", input, options)
  end

  @doc """
  Retrieves properties for a custom game build.

  To request a build resource, specify a build ID. If successful, an object
  containing the build properties is returned.

  ## Learn more

  [ Upload a Custom Server Build](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-build-intro.html)

  ## Related actions

  `CreateBuild` | `ListBuilds` | `DescribeBuild` | `UpdateBuild` | `DeleteBuild` |
  [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def describe_build(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeBuild", input, options)
  end

  @doc """
  The GameLift service limits and current utilization for an AWS Region or
  location.

  Instance limits control the number of instances, per instance type, per
  location, that your AWS account can use. Learn more at [Amazon EC2 Instance Types](http://aws.amazon.com/ec2/instance-types/). The information returned
  includes the maximum number of instances allowed and your account's current
  usage across all fleets. This information can affect your ability to scale your
  GameLift fleets. You can request a limit increase for your account by using the
  **Service limits** page in the GameLift console.

  Instance limits differ based on whether the instances are deployed in a fleet's
  home Region or in a remote location. For remote locations, limits also differ
  based on the combination of home Region and remote location. All requests must
  specify an AWS Region (either explicitly or as your default settings). To get
  the limit for a remote location, you must also specify the location. For
  example, the following requests all return different results:

    * Request specifies the Region `ap-northeast-1` with no location.
  The result is limits and usage data on all instance types that are deployed in
  `us-east-2`, by all of the fleets that reside in `ap-northeast-1`.

    * Request specifies the Region `us-east-1` with location
  `ca-central-1`. The result is limits and usage data on all instance types that
  are deployed in `ca-central-1`, by all of the fleets that reside in `us-east-2`.
  These limits do not affect fleets in any other Regions that deploy instances to
  `ca-central-1`.

    * Request specifies the Region `eu-west-1` with location
  `ca-central-1`. The result is limits and usage data on all instance types that
  are deployed in `ca-central-1`, by all of the fleets that reside in `eu-west-1`.

  This operation can be used in the following ways:

    * To get limit and usage data for all instance types that are
  deployed in an AWS Region by fleets that reside in the same Region: Specify the
  Region only. Optionally, specify a single instance type to retrieve information
  for.

    * To get limit and usage data for all instance types that are
  deployed to a remote location by fleets that reside in different AWS Region:
  Provide both the AWS Region and the remote location. Optionally, specify a
  single instance type to retrieve information for.

  If successful, an `EC2InstanceLimits` object is returned with limits and usage
  data for each requested instance type.

  ## Learn more

  [Setting up GameLift fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-intro.html)

  ## Related actions

  `CreateFleet` | `UpdateFleetCapacity` | `PutScalingPolicy` |
  `DescribeEC2InstanceLimits` | `DescribeFleetAttributes` |
  `DescribeFleetLocationAttributes` | `UpdateFleetAttributes` | `StopFleetActions`
  | `DeleteFleet` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def describe_ec2_instance_limits(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeEC2InstanceLimits", input, options)
  end

  @doc """
  Retrieves core fleet-wide properties, including the computing hardware and
  deployment configuration for all instances in the fleet.

  This operation can be used in the following ways:

    * To get attributes for one or more specific fleets, provide a list
  of fleet IDs or fleet ARNs.

    * To get attributes for all fleets, do not provide a fleet
  identifier.

  When requesting attributes for multiple fleets, use the pagination parameters to
  retrieve results as a set of sequential pages.

  If successful, a `FleetAttributes` object is returned for each fleet requested,
  unless the fleet identifier is not found.

  Some API operations limit the number of fleet IDs that allowed in one request.
  If a request exceeds this limit, the request fails and the error message
  contains the maximum allowed number.

  ## Learn more

  [Setting up GameLift fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-intro.html)

  ## Related actions

  `ListFleets` | `DescribeEC2InstanceLimits` | `DescribeFleetAttributes` |
  `DescribeFleetCapacity` | `DescribeFleetEvents` |
  `DescribeFleetLocationAttributes` | `DescribeFleetPortSettings` |
  `DescribeFleetUtilization` | `DescribeRuntimeConfiguration` |
  `DescribeScalingPolicies` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def describe_fleet_attributes(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeFleetAttributes", input, options)
  end

  @doc """
  Retrieves the resource capacity settings for one or more fleets.

  The data returned includes the current fleet capacity (number of EC2 instances),
  and settings that can control how capacity scaling. For fleets with remote
  locations, this operation retrieves data for the fleet's home Region only. See
  `DescribeFleetLocationCapacity` to get capacity settings for a fleet's remote
  locations.

  This operation can be used in the following ways:

    * To get capacity data for one or more specific fleets, provide a
  list of fleet IDs or fleet ARNs.

    * To get capacity data for all fleets, do not provide a fleet
  identifier.

  When requesting multiple fleets, use the pagination parameters to retrieve
  results as a set of sequential pages.

  If successful, a `FleetCapacity` object is returned for each requested fleet ID.
  Each FleetCapacity object includes a `Location` property, which is set to the
  fleet's home Region. When a list of fleet IDs is provided, attribute objects are
  returned only for fleets that currently exist.

  Some API operations may limit the number of fleet IDs that are allowed in one
  request. If a request exceeds this limit, the request fails and the error
  message includes the maximum allowed.

  ## Learn more

  [Setting up GameLift fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-intro.html)

  [GameLift metrics for fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/monitoring-cloudwatch.html#gamelift-metrics-fleet)

  ## Related actions

  `ListFleets` | `DescribeEC2InstanceLimits` | `DescribeFleetAttributes` |
  `DescribeFleetCapacity` | `DescribeFleetEvents` |
  `DescribeFleetLocationAttributes` | `DescribeFleetPortSettings` |
  `DescribeFleetUtilization` | `DescribeRuntimeConfiguration` |
  `DescribeScalingPolicies` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def describe_fleet_capacity(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeFleetCapacity", input, options)
  end

  @doc """
  Retrieves entries from a fleet's event log.

  Fleet events are initiated by changes in status, such as during fleet creation
  and termination, changes in capacity, etc. If a fleet has multiple locations,
  events are also initiated by changes to status and capacity in remote locations.

  You can specify a time range to limit the result set. Use the pagination
  parameters to retrieve results as a set of sequential pages.

  If successful, a collection of event log entries matching the request are
  returned.

  ## Learn more

  [Setting up GameLift fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-intro.html)

  ## Related actions

  `ListFleets` | `DescribeEC2InstanceLimits` | `DescribeFleetAttributes` |
  `DescribeFleetCapacity` | `DescribeFleetEvents` |
  `DescribeFleetLocationAttributes` | `DescribeFleetPortSettings` |
  `DescribeFleetUtilization` | `DescribeRuntimeConfiguration` |
  `DescribeScalingPolicies` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def describe_fleet_events(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeFleetEvents", input, options)
  end

  @doc """
  Retrieves information on a fleet's remote locations, including life-cycle status
  and any suspended fleet activity.

  This operation can be used in the following ways:

    * To get data for specific locations, provide a fleet identifier and
  a list of locations. Location data is returned in the order that it is
  requested.

    * To get data for all locations, provide a fleet identifier only.
  Location data is returned in no particular order.

  When requesting attributes for multiple locations, use the pagination parameters
  to retrieve results as a set of sequential pages.

  If successful, a `LocationAttributes` object is returned for each requested
  location. If the fleet does not have a requested location, no information is
  returned. This operation does not return the home Region. To get information on
  a fleet's home Region, call `DescribeFleetAttributes`.

  ## Learn more

  [Setting up GameLift fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-intro.html)

  ## Related actions

  `CreateFleetLocations` | `DescribeFleetLocationAttributes` |
  `DescribeFleetLocationCapacity` | `DescribeFleetLocationUtilization` |
  `DescribeFleetAttributes` | `DescribeFleetCapacity` | `DescribeFleetUtilization`
  | `UpdateFleetCapacity` | `StopFleetActions` | `DeleteFleetLocations` | [All APIs by
  task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def describe_fleet_location_attributes(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeFleetLocationAttributes", input, options)
  end

  @doc """
  Retrieves the resource capacity settings for a fleet location.

  The data returned includes the current capacity (number of EC2 instances) and
  some scaling settings for the requested fleet location. Use this operation to
  retrieve capacity information for a fleet's remote location or home Region (you
  can also retrieve home Region capacity by calling `DescribeFleetCapacity`).

  To retrieve capacity data, identify a fleet and location.

  If successful, a `FleetCapacity` object is returned for the requested fleet
  location.

  ## Learn more

  [Setting up GameLift fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-intro.html)

  [GameLift metrics for fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/monitoring-cloudwatch.html#gamelift-metrics-fleet)

  ## Related actions

  `CreateFleetLocations` | `DescribeFleetLocationAttributes` |
  `DescribeFleetLocationCapacity` | `DescribeFleetLocationUtilization` |
  `DescribeFleetAttributes` | `DescribeFleetCapacity` | `DescribeFleetUtilization`
  | `UpdateFleetCapacity` | `StopFleetActions` | `DeleteFleetLocations` | [All APIs by
  task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def describe_fleet_location_capacity(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeFleetLocationCapacity", input, options)
  end

  @doc """
  Retrieves current usage data for a fleet location.

  Utilization data provides a snapshot of current game hosting activity at the
  requested location. Use this operation to retrieve utilization information for a
  fleet's remote location or home Region (you can also retrieve home Region
  utilization by calling `DescribeFleetUtilization`).

  To retrieve utilization data, identify a fleet and location.

  If successful, a `FleetUtilization` object is returned for the requested fleet
  location.

  ## Learn more

  [Setting up GameLift fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-intro.html)

  [GameLift metrics for fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/monitoring-cloudwatch.html#gamelift-metrics-fleet)

  ## Related actions

  `CreateFleetLocations` | `DescribeFleetLocationAttributes` |
  `DescribeFleetLocationCapacity` | `DescribeFleetLocationUtilization` |
  `DescribeFleetAttributes` | `DescribeFleetCapacity` | `DescribeFleetUtilization`
  | `UpdateFleetCapacity` | `StopFleetActions` | `DeleteFleetLocations` | [All APIs by
  task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def describe_fleet_location_utilization(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeFleetLocationUtilization", input, options)
  end

  @doc """
  Retrieves a fleet's inbound connection permissions.

  Connection permissions specify the range of IP addresses and port settings that
  incoming traffic can use to access server processes in the fleet. Game sessions
  that are running on instances in the fleet must use connections that fall in
  this range.

  This operation can be used in the following ways:

    * To retrieve the inbound connection permissions for a fleet,
  identify the fleet's unique identifier.

    * To check the status of recent updates to a fleet remote location,
  specify the fleet ID and a location. Port setting updates can take time to
  propagate across all locations.

  If successful, a set of `IpPermission` objects is returned for the requested
  fleet ID. When a location is specified, a pending status is included. If the
  requested fleet has been deleted, the result set is empty.

  ## Learn more

  [Setting up GameLift fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-intro.html)

  ## Related actions

  `ListFleets` | `DescribeEC2InstanceLimits` | `DescribeFleetAttributes` |
  `DescribeFleetCapacity` | `DescribeFleetEvents` |
  `DescribeFleetLocationAttributes` | `DescribeFleetPortSettings` |
  `DescribeFleetUtilization` | `DescribeRuntimeConfiguration` |
  `DescribeScalingPolicies` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def describe_fleet_port_settings(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeFleetPortSettings", input, options)
  end

  @doc """
  Retrieves utilization statistics for one or more fleets.

  Utilization data provides a snapshot of how the fleet's hosting resources are
  currently being used. For fleets with remote locations, this operation retrieves
  data for the fleet's home Region only. See `DescribeFleetLocationUtilization` to
  get utilization statistics for a fleet's remote locations.

  This operation can be used in the following ways:

    * To get utilization data for one or more specific fleets, provide a
  list of fleet IDs or fleet ARNs.

    * To get utilization data for all fleets, do not provide a fleet
  identifier.

  When requesting multiple fleets, use the pagination parameters to retrieve
  results as a set of sequential pages.

  If successful, a `FleetUtilization` object is returned for each requested fleet
  ID, unless the fleet identifier is not found. Each fleet utilization object
  includes a `Location` property, which is set to the fleet's home Region.

  Some API operations may limit the number of fleet IDs allowed in one request. If
  a request exceeds this limit, the request fails and the error message includes
  the maximum allowed.

  ## Learn more

  [Setting up GameLift Fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-intro.html)

  [GameLift Metrics for Fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/monitoring-cloudwatch.html#gamelift-metrics-fleet)

  ## Related actions

  `ListFleets` | `DescribeEC2InstanceLimits` | `DescribeFleetAttributes` |
  `DescribeFleetCapacity` | `DescribeFleetEvents` |
  `DescribeFleetLocationAttributes` | `DescribeFleetPortSettings` |
  `DescribeFleetUtilization` | `DescribeRuntimeConfiguration` |
  `DescribeScalingPolicies` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def describe_fleet_utilization(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeFleetUtilization", input, options)
  end

  @doc """
  ## This operation is used with the GameLift FleetIQ solution and game server
  groups.

  Retrieves information for a registered game server.

  Information includes game server status, health check info, and the instance
  that the game server is running on.

  To retrieve game server information, specify the game server ID. If successful,
  the requested game server object is returned.

  ## Learn more

  [GameLift FleetIQ Guide](https://docs.aws.amazon.com/gamelift/latest/fleetiqguide/gsg-intro.html)

  ## Related actions

  `RegisterGameServer` | `ListGameServers` | `ClaimGameServer` |
  `DescribeGameServer` | `UpdateGameServer` | `DeregisterGameServer` | [All APIs by
  task](https://docs.aws.amazon.com/gamelift/latest/fleetiqguide/reference-awssdk-fleetiq.html)
  """
  def describe_game_server(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeGameServer", input, options)
  end

  @doc """
  ## This operation is used with the GameLift FleetIQ solution and game server
  groups.

  Retrieves information on a game server group.

  This operation returns only properties related to GameLift FleetIQ. To view or
  update properties for the corresponding Auto Scaling group, such as launch
  template, auto scaling policies, and maximum/minimum group size, access the Auto
  Scaling group directly.

  To get attributes for a game server group, provide a group name or ARN value. If
  successful, a `GameServerGroup` object is returned.

  ## Learn more

  [GameLift FleetIQ Guide](https://docs.aws.amazon.com/gamelift/latest/fleetiqguide/gsg-intro.html)

  ## Related actions

  `CreateGameServerGroup` | `ListGameServerGroups` | `DescribeGameServerGroup` |
  `UpdateGameServerGroup` | `DeleteGameServerGroup` | `ResumeGameServerGroup` |
  `SuspendGameServerGroup` | `DescribeGameServerInstances` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/fleetiqguide/reference-awssdk-fleetiq.html)
  """
  def describe_game_server_group(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeGameServerGroup", input, options)
  end

  @doc """
  ## This operation is used with the GameLift FleetIQ solution and game server
  groups.

  Retrieves status information about the Amazon EC2 instances associated with a
  GameLift FleetIQ game server group.

  Use this operation to detect when instances are active or not available to host
  new game servers. If you are looking for instance configuration information,
  call `DescribeGameServerGroup` or access the corresponding Auto Scaling group
  properties.

  To request status for all instances in the game server group, provide a game
  server group ID only. To request status for specific instances, provide the game
  server group ID and one or more instance IDs. Use the pagination parameters to
  retrieve results in sequential segments. If successful, a collection of
  `GameServerInstance` objects is returned.

  This operation is not designed to be called with every game server claim
  request; this practice can cause you to exceed your API limit, which results in
  errors. Instead, as a best practice, cache the results and refresh your cache no
  more than once every 10 seconds.

  ## Learn more

  [GameLift FleetIQ Guide](https://docs.aws.amazon.com/gamelift/latest/fleetiqguide/gsg-intro.html)

  ## Related actions

  `CreateGameServerGroup` | `ListGameServerGroups` | `DescribeGameServerGroup` |
  `UpdateGameServerGroup` | `DeleteGameServerGroup` | `ResumeGameServerGroup` |
  `SuspendGameServerGroup` | `DescribeGameServerInstances` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/fleetiqguide/reference-awssdk-fleetiq.html)
  """
  def describe_game_server_instances(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeGameServerInstances", input, options)
  end

  @doc """
  Retrieves additional game session properties, including the game session
  protection policy in force, a set of one or more game sessions in a specific
  fleet location.

  You can optionally filter the results by current game session status.
  Alternatively, use `SearchGameSessions` to request a set of active game sessions
  that are filtered by certain criteria. To retrieve all game session properties,
  use `DescribeGameSessions`.

  This operation can be used in the following ways:

    * To retrieve details for all game sessions that are currently
  running on all locations in a fleet, provide a fleet or alias ID, with an
  optional status filter. This approach returns details from the fleet's home
  Region and all remote locations.

    * To retrieve details for all game sessions that are currently
  running on a specific fleet location, provide a fleet or alias ID and a location
  name, with optional status filter. The location can be the fleet's home Region
  or any remote location.

    * To retrieve details for a specific game session, provide the game
  session ID. This approach looks for the game session ID in all fleets that
  reside in the AWS Region defined in the request.

  Use the pagination parameters to retrieve results as a set of sequential pages.

  If successful, a `GameSessionDetail` object is returned for each game session
  that matches the request.

  ## Learn more

  [Find a game session](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-sdk-client-api.html#gamelift-sdk-client-api-find)

  ## Related actions

  `CreateGameSession` | `DescribeGameSessions` | `DescribeGameSessionDetails` |
  `SearchGameSessions` | `UpdateGameSession` | `GetGameSessionLogUrl` |
  `StartGameSessionPlacement` | `DescribeGameSessionPlacement` |
  `StopGameSessionPlacement` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def describe_game_session_details(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeGameSessionDetails", input, options)
  end

  @doc """
  Retrieves information, including current status, about a game session placement
  request.

  To get game session placement details, specify the placement ID.

  If successful, a `GameSessionPlacement` object is returned.

  ## Related actions

  `CreateGameSession` | `DescribeGameSessions` | `DescribeGameSessionDetails` |
  `SearchGameSessions` | `UpdateGameSession` | `GetGameSessionLogUrl` |
  `StartGameSessionPlacement` | `DescribeGameSessionPlacement` |
  `StopGameSessionPlacement` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def describe_game_session_placement(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeGameSessionPlacement", input, options)
  end

  @doc """
  Retrieves the properties for one or more game session queues.

  When requesting multiple queues, use the pagination parameters to retrieve
  results as a set of sequential pages. If successful, a `GameSessionQueue` object
  is returned for each requested queue. When specifying a list of queues, objects
  are returned only for queues that currently exist in the Region.

  ## Learn more

  [ View Your Queues](https://docs.aws.amazon.com/gamelift/latest/developerguide/queues-console.html)

  ## Related actions

  `CreateGameSessionQueue` | `DescribeGameSessionQueues` |
  `UpdateGameSessionQueue` | `DeleteGameSessionQueue` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def describe_game_session_queues(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeGameSessionQueues", input, options)
  end

  @doc """
  Retrieves a set of one or more game sessions in a specific fleet location.

  You can optionally filter the results by current game session status.
  Alternatively, use `SearchGameSessions` to request a set of active game sessions
  that are filtered by certain criteria. To retrieve the protection policy for
  game sessions, use `DescribeGameSessionDetails`.

  This operation can be used in the following ways:

    * To retrieve all game sessions that are currently running on all
  locations in a fleet, provide a fleet or alias ID, with an optional status
  filter. This approach returns all game sessions in the fleet's home Region and
  all remote locations.

    * To retrieve all game sessions that are currently running on a
  specific fleet location, provide a fleet or alias ID and a location name, with
  optional status filter. The location can be the fleet's home Region or any
  remote location.

    * To retrieve a specific game session, provide the game session ID.
  This approach looks for the game session ID in all fleets that reside in the AWS
  Region defined in the request.

  Use the pagination parameters to retrieve results as a set of sequential pages.

  If successful, a `GameSession` object is returned for each game session that
  matches the request.

  *Available in GameLift Local.*

  ## Learn more

  [Find a game session](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-sdk-client-api.html#gamelift-sdk-client-api-find)

  ## Related actions

  `CreateGameSession` | `DescribeGameSessions` | `DescribeGameSessionDetails` |
  `SearchGameSessions` | `UpdateGameSession` | `GetGameSessionLogUrl` |
  `StartGameSessionPlacement` | `DescribeGameSessionPlacement` |
  `StopGameSessionPlacement` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def describe_game_sessions(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeGameSessions", input, options)
  end

  @doc """
  Retrieves information about a fleet's instances, including instance IDs,
  connection data, and status.

  This operation can be used in the following ways:

    * To get information on all instances that are deployed to a fleet's
  home Region, provide the fleet ID.

    * To get information on all instances that are deployed to a fleet's
  remote location, provide the fleet ID and location name.

    * To get information on a specific instance in a fleet, provide the
  fleet ID and instance ID.

  Use the pagination parameters to retrieve results as a set of sequential pages.

  If successful, an `Instance` object is returned for each requested instance.
  Instances are not returned in any particular order.

  ## Learn more

  [Remotely Access Fleet Instances](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-remote-access.html)

  [Debug Fleet Issues](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-creating-debug.html)

  ## Related actions

  `DescribeInstances` | `GetInstanceAccess` | `DescribeEC2InstanceLimits` | [All APIs by
  task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def describe_instances(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeInstances", input, options)
  end

  @doc """
  Retrieves one or more matchmaking tickets.

  Use this operation to retrieve ticket information, including--after a successful
  match is made--connection information for the resulting new game session.

  To request matchmaking tickets, provide a list of up to 10 ticket IDs. If the
  request is successful, a ticket object is returned for each requested ID that
  currently exists.

  This operation is not designed to be continually called to track matchmaking
  ticket status. This practice can cause you to exceed your API limit, which
  results in errors. Instead, as a best practice, set up an Amazon Simple
  Notification Service (SNS) to receive notifications, and provide the topic ARN
  in the matchmaking configuration. Continuously poling ticket status with
  `DescribeMatchmaking` should only be used for games in development with low
  matchmaking usage.

  ## Learn more

  [ Add FlexMatch to a game client](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/match-client.html)

  [ Set Up FlexMatch event notification](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/match-notification.html)

  ## Related actions

  `StartMatchmaking` | `DescribeMatchmaking` | `StopMatchmaking` | `AcceptMatch` |
  `StartMatchBackfill` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def describe_matchmaking(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeMatchmaking", input, options)
  end

  @doc """
  Retrieves the details of FlexMatch matchmaking configurations.

  This operation offers the following options: (1) retrieve all matchmaking
  configurations, (2) retrieve configurations for a specified list, or (3)
  retrieve all configurations that use a specified rule set name. When requesting
  multiple items, use the pagination parameters to retrieve results as a set of
  sequential pages.

  If successful, a configuration is returned for each requested name. When
  specifying a list of names, only configurations that currently exist are
  returned.

  ## Learn more

  [ Setting up FlexMatch matchmakers](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/matchmaker-build.html)

  ## Related actions

  `CreateMatchmakingConfiguration` | `DescribeMatchmakingConfigurations` |
  `UpdateMatchmakingConfiguration` | `DeleteMatchmakingConfiguration` |
  `CreateMatchmakingRuleSet` | `DescribeMatchmakingRuleSets` |
  `ValidateMatchmakingRuleSet` | `DeleteMatchmakingRuleSet` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def describe_matchmaking_configurations(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeMatchmakingConfigurations", input, options)
  end

  @doc """
  Retrieves the details for FlexMatch matchmaking rule sets.

  You can request all existing rule sets for the Region, or provide a list of one
  or more rule set names. When requesting multiple items, use the pagination
  parameters to retrieve results as a set of sequential pages. If successful, a
  rule set is returned for each requested name.

  ## Learn more

    * [Build a rule set](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/match-rulesets.html)

  ## Related actions

  `CreateMatchmakingConfiguration` | `DescribeMatchmakingConfigurations` |
  `UpdateMatchmakingConfiguration` | `DeleteMatchmakingConfiguration` |
  `CreateMatchmakingRuleSet` | `DescribeMatchmakingRuleSets` |
  `ValidateMatchmakingRuleSet` | `DeleteMatchmakingRuleSet` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def describe_matchmaking_rule_sets(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeMatchmakingRuleSets", input, options)
  end

  @doc """
  Retrieves properties for one or more player sessions.

  This action can be used in the following ways:

    * To retrieve a specific player session, provide the player session
  ID only.

    * To retrieve all player sessions in a game session, provide the
  game session ID only.

    * To retrieve all player sessions for a specific player, provide a
  player ID only.

  To request player sessions, specify either a player session ID, game session ID,
  or player ID. You can filter this request by player session status. Use the
  pagination parameters to retrieve results as a set of sequential pages.

  If successful, a `PlayerSession` object is returned for each session that
  matches the request.

  *Available in Amazon GameLift Local.*

  ## Related actions

  `CreatePlayerSession` | `CreatePlayerSessions` | `DescribePlayerSessions` |
  `StartGameSessionPlacement` | `DescribeGameSessionPlacement` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def describe_player_sessions(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribePlayerSessions", input, options)
  end

  @doc """
  Retrieves a fleet's runtime configuration settings.

  The runtime configuration tells GameLift which server processes to run (and how)
  on each instance in the fleet.

  To get the runtime configuration that is currently in forces for a fleet,
  provide the fleet ID.

  If successful, a `RuntimeConfiguration` object is returned for the requested
  fleet. If the requested fleet has been deleted, the result set is empty.

  ## Learn more

  [Setting up GameLift fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-intro.html)

  [Running multiple processes on a fleet](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-multiprocess.html)

  ## Related actions

  `ListFleets` | `DescribeEC2InstanceLimits` | `DescribeFleetAttributes` |
  `DescribeFleetCapacity` | `DescribeFleetEvents` |
  `DescribeFleetLocationAttributes` | `DescribeFleetPortSettings` |
  `DescribeFleetUtilization` | `DescribeRuntimeConfiguration` |
  `DescribeScalingPolicies` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def describe_runtime_configuration(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeRuntimeConfiguration", input, options)
  end

  @doc """
  Retrieves all scaling policies applied to a fleet.

  To get a fleet's scaling policies, specify the fleet ID. You can filter this
  request by policy status, such as to retrieve only active scaling policies. Use
  the pagination parameters to retrieve results as a set of sequential pages. If
  successful, set of `ScalingPolicy` objects is returned for the fleet.

  A fleet may have all of its scaling policies suspended (`StopFleetActions`).
  This operation does not affect the status of the scaling policies, which remains
  ACTIVE. To see whether a fleet's scaling policies are in force or suspended,
  call `DescribeFleetAttributes` and check the stopped actions.

  ## Related actions

  `DescribeFleetCapacity` | `UpdateFleetCapacity` | `DescribeEC2InstanceLimits` |
  `PutScalingPolicy` | `DescribeScalingPolicies` | `DeleteScalingPolicy` |
  `StopFleetActions` | `StartFleetActions` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def describe_scaling_policies(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeScalingPolicies", input, options)
  end

  @doc """
  Retrieves properties for a Realtime script.

  To request a script record, specify the script ID. If successful, an object
  containing the script properties is returned.

  ## Learn more

  [Amazon GameLift Realtime Servers](https://docs.aws.amazon.com/gamelift/latest/developerguide/realtime-intro.html)

  ## Related actions

  `CreateScript` | `ListScripts` | `DescribeScript` | `UpdateScript` |
  `DeleteScript` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def describe_script(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeScript", input, options)
  end

  @doc """
  Retrieves valid VPC peering authorizations that are pending for the AWS account.

  This operation returns all VPC peering authorizations and requests for peering.
  This includes those initiated and received by this account.

  ## Related actions

  `CreateVpcPeeringAuthorization` | `DescribeVpcPeeringAuthorizations` |
  `DeleteVpcPeeringAuthorization` | `CreateVpcPeeringConnection` |
  `DescribeVpcPeeringConnections` | `DeleteVpcPeeringConnection` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def describe_vpc_peering_authorizations(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeVpcPeeringAuthorizations", input, options)
  end

  @doc """
  Retrieves information on VPC peering connections.

  Use this operation to get peering information for all fleets or for one specific
  fleet ID.

  To retrieve connection information, call this operation from the AWS account
  that is used to manage the Amazon GameLift fleets. Specify a fleet ID or leave
  the parameter empty to retrieve all connection records. If successful, the
  retrieved information includes both active and pending connections. Active
  connections identify the IpV4 CIDR block that the VPC uses to connect.

  ## Related actions

  `CreateVpcPeeringAuthorization` | `DescribeVpcPeeringAuthorizations` |
  `DeleteVpcPeeringAuthorization` | `CreateVpcPeeringConnection` |
  `DescribeVpcPeeringConnections` | `DeleteVpcPeeringConnection` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def describe_vpc_peering_connections(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeVpcPeeringConnections", input, options)
  end

  @doc """
  Retrieves the location of stored game session logs for a specified game session.

  When a game session is terminated, GameLift automatically stores the logs in
  Amazon S3 and retains them for 14 days. Use this URL to download the logs.

  See the [AWS Service Limits](https://docs.aws.amazon.com/general/latest/gr/aws_service_limits.html#limits_gamelift)
  page for maximum log file sizes. Log files that exceed this limit are not saved.

  ## Related actions

  `CreateGameSession` | `DescribeGameSessions` | `DescribeGameSessionDetails` |
  `SearchGameSessions` | `UpdateGameSession` | `GetGameSessionLogUrl` |
  `StartGameSessionPlacement` | `DescribeGameSessionPlacement` |
  `StopGameSessionPlacement` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def get_game_session_log_url(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "GetGameSessionLogUrl", input, options)
  end

  @doc """
  Requests remote access to a fleet instance.

  Remote access is useful for debugging, gathering benchmarking data, or observing
  activity in real time.

  To remotely access an instance, you need credentials that match the operating
  system of the instance. For a Windows instance, GameLift returns a user name and
  password as strings for use with a Windows Remote Desktop client. For a Linux
  instance, GameLift returns a user name and RSA private key, also as strings, for
  use with an SSH client. The private key must be saved in the proper format to a
  `.pem` file before using. If you're making this request using the AWS CLI,
  saving the secret can be handled as part of the `GetInstanceAccess` request, as
  shown in one of the examples for this operation.

  To request access to a specific instance, specify the IDs of both the instance
  and the fleet it belongs to. You can retrieve a fleet's instance IDs by calling
  `DescribeInstances`. If successful, an `InstanceAccess` object is returned that
  contains the instance's IP address and a set of credentials.

  ## Learn more

  [Remotely Access Fleet Instances](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-remote-access.html)

  [Debug Fleet Issues](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-creating-debug.html)

  ## Related actions

  `DescribeInstances` | `GetInstanceAccess` | `DescribeEC2InstanceLimits` | [All APIs by
  task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def get_instance_access(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "GetInstanceAccess", input, options)
  end

  @doc """
  Retrieves all aliases for this AWS account.

  You can filter the result set by alias name and/or routing strategy type. Use
  the pagination parameters to retrieve results in sequential pages.

  Returned aliases are not listed in any particular order.

  ## Related actions

  `CreateAlias` | `ListAliases` | `DescribeAlias` | `UpdateAlias` | `DeleteAlias`
  | `ResolveAlias` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def list_aliases(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "ListAliases", input, options)
  end

  @doc """
  Retrieves build resources for all builds associated with the AWS account in use.

  You can limit results to builds that are in a specific status by using the
  `Status` parameter. Use the pagination parameters to retrieve results in a set
  of sequential pages.

  Build resources are not listed in any particular order.

  ## Learn more

  [ Upload a Custom Server Build](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-build-intro.html)

  ## Related actions

  `CreateBuild` | `ListBuilds` | `DescribeBuild` | `UpdateBuild` | `DeleteBuild` |
  [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def list_builds(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "ListBuilds", input, options)
  end

  @doc """
  Retrieves a collection of fleet resources in an AWS Region.

  You can call this operation to get fleets in a previously selected default
  Region (see
  [https://docs.aws.amazon.com/credref/latest/refdocs/setting-global-region.html](https://docs.aws.amazon.com/credref/latest/refdocs/setting-global-region.html)or specify a Region in your request. You can filter the result set to find only
  those fleets that are deployed with a specific build or script. For fleets that
  have multiple locations, this operation retrieves fleets based on their home
  Region only.

  This operation can be used in the following ways:

    * To get a list of all fleets in a Region, don't provide a build or
  script identifier.

    * To get a list of all fleets where a specific custom game build is
  deployed, provide the build ID.

    * To get a list of all Realtime Servers fleets with a specific
  configuration script, provide the script ID.

  Use the pagination parameters to retrieve results as a set of sequential pages.

  If successful, a list of fleet IDs that match the request parameters is
  returned. A NextToken value is also returned if there are more result pages to
  retrieve.

  Fleet resources are not listed in a particular order.

  ## Learn more

  [Setting up GameLift
  fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-intro.html)

  ## Related actions

  `CreateFleet` | `UpdateFleetCapacity` | `PutScalingPolicy` |
  `DescribeEC2InstanceLimits` | `DescribeFleetAttributes` |
  `DescribeFleetLocationAttributes` | `UpdateFleetAttributes` | `StopFleetActions`
  | `DeleteFleet` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def list_fleets(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "ListFleets", input, options)
  end

  @doc """
  ## This operation is used with the GameLift FleetIQ solution and game server
  groups.

  Retrieves information on all game servers groups that exist in the current AWS
  account for the selected Region.

  Use the pagination parameters to retrieve results in a set of sequential
  segments.

  ## Learn more

  [GameLift FleetIQ Guide](https://docs.aws.amazon.com/gamelift/latest/fleetiqguide/gsg-intro.html)

  ## Related actions

  `CreateGameServerGroup` | `ListGameServerGroups` | `DescribeGameServerGroup` |
  `UpdateGameServerGroup` | `DeleteGameServerGroup` | `ResumeGameServerGroup` |
  `SuspendGameServerGroup` | `DescribeGameServerInstances` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/fleetiqguide/reference-awssdk-fleetiq.html)
  """
  def list_game_server_groups(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "ListGameServerGroups", input, options)
  end

  @doc """
  ## This operation is used with the GameLift FleetIQ solution and game server
  groups.

  Retrieves information on all game servers that are currently active in a
  specified game server group.

  You can opt to sort the list by game server age. Use the pagination parameters
  to retrieve results in a set of sequential segments.

  ## Learn more

  [GameLift FleetIQ Guide](https://docs.aws.amazon.com/gamelift/latest/fleetiqguide/gsg-intro.html)

  ## Related actions

  `RegisterGameServer` | `ListGameServers` | `ClaimGameServer` |
  `DescribeGameServer` | `UpdateGameServer` | `DeregisterGameServer` | [All APIs by
  task](https://docs.aws.amazon.com/gamelift/latest/fleetiqguide/reference-awssdk-fleetiq.html)
  """
  def list_game_servers(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "ListGameServers", input, options)
  end

  @doc """
  Retrieves script records for all Realtime scripts that are associated with the
  AWS account in use.

  ## Learn more

  [Amazon GameLift Realtime Servers](https://docs.aws.amazon.com/gamelift/latest/developerguide/realtime-intro.html)

  ## Related actions

  `CreateScript` | `ListScripts` | `DescribeScript` | `UpdateScript` |
  `DeleteScript` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def list_scripts(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "ListScripts", input, options)
  end

  @doc """
  Retrieves all tags that are assigned to a GameLift resource.

  Resource tags are used to organize AWS resources for a range of purposes. This
  operation handles the permissions necessary to manage tags for the following
  GameLift resource types:

    * Build

    * Script

    * Fleet

    * Alias

    * GameSessionQueue

    * MatchmakingConfiguration

    * MatchmakingRuleSet

  To list tags for a resource, specify the unique ARN value for the resource.

  ## Learn more

  [Tagging AWS Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html) in
  the *AWS General Reference*

  [ AWS Tagging Strategies](http://aws.amazon.com/answers/account-management/aws-tagging-strategies/)

  ## Related actions

  `TagResource` | `UntagResource` | `ListTagsForResource` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def list_tags_for_resource(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "ListTagsForResource", input, options)
  end

  @doc """
  Creates or updates a scaling policy for a fleet.

  Scaling policies are used to automatically scale a fleet's hosting capacity to
  meet player demand. An active scaling policy instructs Amazon GameLift to track
  a fleet metric and automatically change the fleet's capacity when a certain
  threshold is reached. There are two types of scaling policies: target-based and
  rule-based. Use a target-based policy to quickly and efficiently manage fleet
  scaling; this option is the most commonly used. Use rule-based policies when you
  need to exert fine-grained control over auto-scaling.

  Fleets can have multiple scaling policies of each type in force at the same
  time; you can have one target-based policy, one or multiple rule-based scaling
  policies, or both. We recommend caution, however, because multiple auto-scaling
  policies can have unintended consequences.

  You can temporarily suspend all scaling policies for a fleet by calling
  `StopFleetActions` with the fleet action AUTO_SCALING. To resume scaling
  policies, call `StartFleetActions` with the same fleet action. To stop just one
  scaling policy--or to permanently remove it, you must delete the policy with
  `DeleteScalingPolicy`.

  Learn more about how to work with auto-scaling in [Set Up Fleet Automatic Scaling](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-autoscaling.html).

  ## Target-based policy

  A target-based policy tracks a single metric: PercentAvailableGameSessions. This
  metric tells us how much of a fleet's hosting capacity is ready to host game
  sessions but is not currently in use. This is the fleet's buffer; it measures
  the additional player demand that the fleet could handle at current capacity.
  With a target-based policy, you set your ideal buffer size and leave it to
  Amazon GameLift to take whatever action is needed to maintain that target.

  For example, you might choose to maintain a 10% buffer for a fleet that has the
  capacity to host 100 simultaneous game sessions. This policy tells Amazon
  GameLift to take action whenever the fleet's available capacity falls below or
  rises above 10 game sessions. Amazon GameLift will start new instances or stop
  unused instances in order to return to the 10% buffer.

  To create or update a target-based policy, specify a fleet ID and name, and set
  the policy type to "TargetBased". Specify the metric to track
  (PercentAvailableGameSessions) and reference a `TargetConfiguration` object with
  your desired buffer value. Exclude all other parameters. On a successful
  request, the policy name is returned. The scaling policy is automatically in
  force as soon as it's successfully created. If the fleet's auto-scaling actions
  are temporarily suspended, the new policy will be in force once the fleet
  actions are restarted.

  ## Rule-based policy

  A rule-based policy tracks specified fleet metric, sets a threshold value, and
  specifies the type of action to initiate when triggered. With a rule-based
  policy, you can select from several available fleet metrics. Each policy
  specifies whether to scale up or scale down (and by how much), so you need one
  policy for each type of action.

  For example, a policy may make the following statement: "If the percentage of
  idle instances is greater than 20% for more than 15 minutes, then reduce the
  fleet capacity by 10%."

  A policy's rule statement has the following structure:

  If `[MetricName]` is `[ComparisonOperator]` `[Threshold]` for `[EvaluationPeriods]` minutes, then `[ScalingAdjustmentType]` to/by `[ScalingAdjustment]`.

  To implement the example, the rule statement would look like this:

  If `[PercentIdleInstances]` is `[GreaterThanThreshold]` `[20]` for `[15]` minutes, then `[PercentChangeInCapacity]` to/by `[10]`.  To create or update a scaling policy, specify a unique combination of name and
  fleet ID, and set the policy type to "RuleBased". Specify the parameter values
  for a policy rule statement. On a successful request, the policy name is
  returned. Scaling policies are automatically in force as soon as they're
  successfully created. If the fleet's auto-scaling actions are temporarily
  suspended, the new policy will be in force once the fleet actions are restarted.

  ## Related actions

  `DescribeFleetCapacity` | `UpdateFleetCapacity` | `DescribeEC2InstanceLimits` |
  `PutScalingPolicy` | `DescribeScalingPolicies` | `DeleteScalingPolicy` |
  `StopFleetActions` | `StartFleetActions` | [All APIs by
  task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def put_scaling_policy(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "PutScalingPolicy", input, options)
  end

  @doc """
  ## This operation is used with the GameLift FleetIQ solution and game server
  groups.

  Creates a new game server resource and notifies GameLift FleetIQ that the game
  server is ready to host gameplay and players.

  This operation is called by a game server process that is running on an instance
  in a game server group. Registering game servers enables GameLift FleetIQ to
  track available game servers and enables game clients and services to claim a
  game server for a new game session.

  To register a game server, identify the game server group and instance where the
  game server is running, and provide a unique identifier for the game server. You
  can also include connection and game server data. When a game client or service
  requests a game server by calling `ClaimGameServer`, this information is
  returned in the response.

  Once a game server is successfully registered, it is put in status `AVAILABLE`.
  A request to register a game server may fail if the instance it is running on is
  in the process of shutting down as part of instance balancing or scale-down
  activity.

  ## Learn more

  [GameLift FleetIQ Guide](https://docs.aws.amazon.com/gamelift/latest/fleetiqguide/gsg-intro.html)

  ## Related actions

  `RegisterGameServer` | `ListGameServers` | `ClaimGameServer` |
  `DescribeGameServer` | `UpdateGameServer` | `DeregisterGameServer` | [All APIs by
  task](https://docs.aws.amazon.com/gamelift/latest/fleetiqguide/reference-awssdk-fleetiq.html)
  """
  def register_game_server(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "RegisterGameServer", input, options)
  end

  @doc """
  Retrieves a fresh set of credentials for use when uploading a new set of game
  build files to Amazon GameLift's Amazon S3.

  This is done as part of the build creation process; see `CreateBuild`.

  To request new credentials, specify the build ID as returned with an initial
  `CreateBuild` request. If successful, a new set of credentials are returned,
  along with the S3 storage location associated with the build ID.

  ## Learn more

  [ Create a Build with Files in S3](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-build-cli-uploading.html#gamelift-build-cli-uploading-create-build)

  ## Related actions

  `CreateBuild` | `ListBuilds` | `DescribeBuild` | `UpdateBuild` | `DeleteBuild` |
  [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def request_upload_credentials(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "RequestUploadCredentials", input, options)
  end

  @doc """
  Retrieves the fleet ID that an alias is currently pointing to.

  ## Related actions

  `CreateAlias` | `ListAliases` | `DescribeAlias` | `UpdateAlias` | `DeleteAlias`
  | `ResolveAlias` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def resolve_alias(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "ResolveAlias", input, options)
  end

  @doc """
  ## This operation is used with the GameLift FleetIQ solution and game server
  groups.

  Reinstates activity on a game server group after it has been suspended.

  A game server group might be suspended by the`SuspendGameServerGroup` operation,
  or it might be suspended involuntarily due to a configuration problem. In the
  second case, you can manually resume activity on the group once the
  configuration problem has been resolved. Refer to the game server group status
  and status reason for more information on why group activity is suspended.

  To resume activity, specify a game server group ARN and the type of activity to
  be resumed. If successful, a `GameServerGroup` object is returned showing that
  the resumed activity is no longer listed in `SuspendedActions`.

  ## Learn more

  [GameLift FleetIQ Guide](https://docs.aws.amazon.com/gamelift/latest/fleetiqguide/gsg-intro.html)

  ## Related actions

  `CreateGameServerGroup` | `ListGameServerGroups` | `DescribeGameServerGroup` |
  `UpdateGameServerGroup` | `DeleteGameServerGroup` | `ResumeGameServerGroup` |
  `SuspendGameServerGroup` | `DescribeGameServerInstances` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/fleetiqguide/reference-awssdk-fleetiq.html)
  """
  def resume_game_server_group(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "ResumeGameServerGroup", input, options)
  end

  @doc """
  Retrieves all active game sessions that match a set of search criteria and sorts
  them into a specified order.

  When searching for game sessions, you specify exactly where you want to search
  and provide a search filter expression, a sort expression, or both. A search
  request can search only one fleet, but it can search all of a fleet's locations.

  This operation can be used in the following ways:

    * To search all game sessions that are currently running on all
  locations in a fleet, provide a fleet or alias ID. This approach returns game
  sessions in the fleet's home Region and all remote locations that fit the search
  criteria.

    * To search all game sessions that are currently running on a
  specific fleet location, provide a fleet or alias ID and a location name. For
  location, you can specify a fleet's home Region or any remote location.

  Use the pagination parameters to retrieve results as a set of sequential pages.

  If successful, a `GameSession` object is returned for each game session that
  matches the request. Search finds game sessions that are in `ACTIVE` status
  only. To retrieve information on game sessions in other statuses, use
  `DescribeGameSessions`.

  You can search or sort by the following game session attributes:

    * **gameSessionId** -- A unique identifier for the game session. You
  can use either a `GameSessionId` or `GameSessionArn` value.

    * **gameSessionName** -- Name assigned to a game session. This value
  is set when requesting a new game session with `CreateGameSession` or updating
  with `UpdateGameSession`. Game session names do not need to be unique to a game
  session.

    * **gameSessionProperties** -- Custom data defined in a game
  session's `GameProperty` parameter. `GameProperty` values are stored as
  key:value pairs; the filter expression must indicate the key and a string to
  search the data values for. For example, to search for game sessions with custom
  data containing the key:value pair "gameMode:brawl", specify the following:
  `gameSessionProperties.gameMode = "brawl"`. All custom data values are searched
  as strings.

    * **maximumSessions** -- Maximum number of player sessions allowed
  for a game session. This value is set when requesting a new game session with
  `CreateGameSession` or updating with `UpdateGameSession`.

    * **creationTimeMillis** -- Value indicating when a game session was
  created. It is expressed in Unix time as milliseconds.

    * **playerSessionCount** -- Number of players currently connected to
  a game session. This value changes rapidly as players join the session or drop
  out.

    * **hasAvailablePlayerSessions** -- Boolean value indicating whether
  a game session has reached its maximum number of players. It is highly
  recommended that all search requests include this filter attribute to optimize
  search performance and return only sessions that players can join.

  Returned values for `playerSessionCount` and `hasAvailablePlayerSessions` change
  quickly as players join sessions and others drop out. Results should be
  considered a snapshot in time. Be sure to refresh search results often, and
  handle sessions that fill up before a player can join.

  ## Related actions

  `CreateGameSession` | `DescribeGameSessions` | `DescribeGameSessionDetails` |
  `SearchGameSessions` | `UpdateGameSession` | `GetGameSessionLogUrl` |
  `StartGameSessionPlacement` | `DescribeGameSessionPlacement` |
  `StopGameSessionPlacement` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def search_game_sessions(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "SearchGameSessions", input, options)
  end

  @doc """
  Resumes certain types of activity on fleet instances that were suspended with
  `StopFleetActions`.

  For multi-location fleets, fleet actions are managed separately for each
  location. Currently, this operation is used to restart a fleet's auto-scaling
  activity.

  This operation can be used in the following ways:

    * To restart actions on instances in the fleet's home Region,
  provide a fleet ID and the type of actions to resume.

    * To restart actions on instances in one of the fleet's remote
  locations, provide a fleet ID, a location name, and the type of actions to
  resume.

  If successful, GameLift once again initiates scaling events as triggered by the
  fleet's scaling policies. If actions on the fleet location were never stopped,
  this operation will have no effect. You can view a fleet's stopped actions using
  `DescribeFleetAttributes` or `DescribeFleetLocationAttributes`.

  ## Learn more

  [Setting up GameLift fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-intro.html)

  ## Related actions

  `CreateFleet` | `UpdateFleetCapacity` | `PutScalingPolicy` |
  `DescribeEC2InstanceLimits` | `DescribeFleetAttributes` |
  `DescribeFleetLocationAttributes` | `UpdateFleetAttributes` | `StopFleetActions`
  | `DeleteFleet` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def start_fleet_actions(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "StartFleetActions", input, options)
  end

  @doc """
  Places a request for a new game session in a queue (see
  `CreateGameSessionQueue`).

  When processing a placement request, Amazon GameLift searches for available
  resources on the queue's destinations, scanning each until it finds resources or
  the placement request times out.

  A game session placement request can also request player sessions. When a new
  game session is successfully created, Amazon GameLift creates a player session
  for each player included in the request.

  When placing a game session, by default Amazon GameLift tries each fleet in the
  order they are listed in the queue configuration. Ideally, a queue's
  destinations are listed in preference order.

  Alternatively, when requesting a game session with players, you can also provide
  latency data for each player in relevant Regions. Latency data indicates the
  performance lag a player experiences when connected to a fleet in the Region.
  Amazon GameLift uses latency data to reorder the list of destinations to place
  the game session in a Region with minimal lag. If latency data is provided for
  multiple players, Amazon GameLift calculates each Region's average lag for all
  players and reorders to get the best game play across all players.

  To place a new game session request, specify the following:

    * The queue name and a set of game session properties and settings

    * A unique ID (such as a UUID) for the placement. You use this ID to
  track the status of the placement request

    * (Optional) A set of player data and a unique player ID for each
  player that you are joining to the new game session (player data is optional,
  but if you include it, you must also provide a unique ID for each player)

    * Latency data for all players (if you want to optimize game play
  for the players)

  If successful, a new game session placement is created.

  To track the status of a placement request, call `DescribeGameSessionPlacement`
  and check the request's status. If the status is `FULFILLED`, a new game session
  has been created and a game session ARN and Region are referenced. If the
  placement request times out, you can resubmit the request or retry it with a
  different queue.

  ## Related actions

  `CreateGameSession` | `DescribeGameSessions` | `DescribeGameSessionDetails` |
  `SearchGameSessions` | `UpdateGameSession` | `GetGameSessionLogUrl` |
  `StartGameSessionPlacement` | `DescribeGameSessionPlacement` |
  `StopGameSessionPlacement` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def start_game_session_placement(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "StartGameSessionPlacement", input, options)
  end

  @doc """
  Finds new players to fill open slots in currently running game sessions.

  The backfill match process is essentially identical to the process of forming
  new matches. Backfill requests use the same matchmaker that was used to make the
  original match, and they provide matchmaking data for all players currently in
  the game session. FlexMatch uses this information to select new players so that
  backfilled match continues to meet the original match requirements.

  When using FlexMatch with GameLift managed hosting, you can request a backfill
  match from a client service by calling this operation with a `GameSession`
  identifier. You also have the option of making backfill requests directly from
  your game server. In response to a request, FlexMatch creates player sessions
  for the new players, updates the `GameSession` resource, and sends updated
  matchmaking data to the game server. You can request a backfill match at any
  point after a game session is started. Each game session can have only one
  active backfill request at a time; a subsequent request automatically replaces
  the earlier request.

  When using FlexMatch as a standalone component, request a backfill match by
  calling this operation without a game session identifier. As with newly formed
  matches, matchmaking results are returned in a matchmaking event so that your
  game can update the game session that is being backfilled.

  To request a backfill match, specify a unique ticket ID, the original
  matchmaking configuration, and matchmaking data for all current players in the
  game session being backfilled. Optionally, specify the `GameSession` ARN. If
  successful, a match backfill ticket is created and returned with status set to
  QUEUED. Track the status of backfill tickets using the same method for tracking
  tickets for new matches.

  ## Learn more

  [ Backfill existing games with FlexMatch](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/match-backfill.html)

  [ Matchmaking events](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/match-events.html)
  (reference)

  [ How GameLift FlexMatch works](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/gamelift-match.html)

  ## Related actions

  `StartMatchmaking` | `DescribeMatchmaking` | `StopMatchmaking` | `AcceptMatch` |
  `StartMatchBackfill` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def start_match_backfill(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "StartMatchBackfill", input, options)
  end

  @doc """
  Uses FlexMatch to create a game match for a group of players based on custom
  matchmaking rules.

  With games that use GameLift managed hosting, this operation also triggers
  GameLift to find hosting resources and start a new game session for the new
  match. Each matchmaking request includes information on one or more players and
  specifies the FlexMatch matchmaker to use. When a request is for multiple
  players, FlexMatch attempts to build a match that includes all players in the
  request, placing them in the same team and finding additional players as needed
  to fill the match.

  To start matchmaking, provide a unique ticket ID, specify a matchmaking
  configuration, and include the players to be matched. You must also include any
  player attributes that are required by the matchmaking configuration's rule set.
  If successful, a matchmaking ticket is returned with status set to `QUEUED`.

  Track matchmaking events to respond as needed and acquire game session
  connection information for successfully completed matches. Ticket status updates
  are tracked using event notification through Amazon Simple Notification Service
  (SNS), which is defined in the matchmaking configuration.

  ## Learn more

  [ Add FlexMatch to a game client](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/match-client.html)

  [ Set Up FlexMatch event notification](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/match-notification.html)

  [ How GameLift FlexMatch works](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/gamelift-match.html)

  ## Related actions

  `StartMatchmaking` | `DescribeMatchmaking` | `StopMatchmaking` | `AcceptMatch` |
  `StartMatchBackfill` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def start_matchmaking(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "StartMatchmaking", input, options)
  end

  @doc """
  Suspends certain types of activity in a fleet location.

  Currently, this operation is used to stop auto-scaling activity. For
  multi-location fleets, fleet actions are managed separately for each location.

  Stopping fleet actions has several potential purposes. It allows you to
  temporarily stop auto-scaling activity but retain your scaling policies for use
  in the future. For multi-location fleets, you can set up fleet-wide
  auto-scaling, and then opt out of it for certain locations.

  This operation can be used in the following ways:

    * To stop actions on instances in the fleet's home Region, provide a
  fleet ID and the type of actions to suspend.

    * To stop actions on instances in one of the fleet's remote
  locations, provide a fleet ID, a location name, and the type of actions to
  suspend.

  If successful, GameLift no longer initiates scaling events except in response to
  manual changes using `UpdateFleetCapacity`. You can view a fleet's stopped
  actions using `DescribeFleetAttributes` or `DescribeFleetLocationAttributes`.
  Suspended activity can be restarted using `StartFleetActions`.

  ## Learn more

  [Setting up GameLift Fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-intro.html)

  ## Related actions

  `CreateFleet` | `UpdateFleetCapacity` | `PutScalingPolicy` |
  `DescribeEC2InstanceLimits` | `DescribeFleetAttributes` |
  `DescribeFleetLocationAttributes` | `UpdateFleetAttributes` | `StopFleetActions`
  | `DeleteFleet` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def stop_fleet_actions(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "StopFleetActions", input, options)
  end

  @doc """
  Cancels a game session placement that is in `PENDING` status.

  To stop a placement, provide the placement ID values. If successful, the
  placement is moved to `CANCELLED` status.

  ## Related actions

  `CreateGameSession` | `DescribeGameSessions` | `DescribeGameSessionDetails` |
  `SearchGameSessions` | `UpdateGameSession` | `GetGameSessionLogUrl` |
  `StartGameSessionPlacement` | `DescribeGameSessionPlacement` |
  `StopGameSessionPlacement` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def stop_game_session_placement(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "StopGameSessionPlacement", input, options)
  end

  @doc """
  Cancels a matchmaking ticket or match backfill ticket that is currently being
  processed.

  To stop the matchmaking operation, specify the ticket ID. If successful, work on
  the ticket is stopped, and the ticket status is changed to `CANCELLED`.

  This call is also used to turn off automatic backfill for an individual game
  session. This is for game sessions that are created with a matchmaking
  configuration that has automatic backfill enabled. The ticket ID is included in
  the `MatchmakerData` of an updated game session object, which is provided to the
  game server.

  If the operation is successful, the service sends back an empty JSON struct with
  the HTTP 200 response (not an empty HTTP body).

  ## Learn more

  [ Add FlexMatch to a game client](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/match-client.html)

  ## Related actions

  `StartMatchmaking` | `DescribeMatchmaking` | `StopMatchmaking` | `AcceptMatch` |
  `StartMatchBackfill` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def stop_matchmaking(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "StopMatchmaking", input, options)
  end

  @doc """
  ## This operation is used with the GameLift FleetIQ solution and game server
  groups.

  Temporarily stops activity on a game server group without terminating instances
  or the game server group.

  You can restart activity by calling `ResumeGameServerGroup`. You can suspend the
  following activity:

    * **Instance type replacement** - This activity evaluates the
  current game hosting viability of all Spot instance types that are defined for
  the game server group. It updates the Auto Scaling group to remove nonviable
  Spot Instance types, which have a higher chance of game server interruptions. It
  then balances capacity across the remaining viable Spot Instance types. When
  this activity is suspended, the Auto Scaling group continues with its current
  balance, regardless of viability. Instance protection, utilization metrics, and
  capacity scaling activities continue to be active.

  To suspend activity, specify a game server group ARN and the type of activity to
  be suspended. If successful, a `GameServerGroup` object is returned showing that
  the activity is listed in `SuspendedActions`.

  ## Learn more

  [GameLift FleetIQ Guide](https://docs.aws.amazon.com/gamelift/latest/fleetiqguide/gsg-intro.html)

  ## Related actions

  `CreateGameServerGroup` | `ListGameServerGroups` | `DescribeGameServerGroup` |
  `UpdateGameServerGroup` | `DeleteGameServerGroup` | `ResumeGameServerGroup` |
  `SuspendGameServerGroup` | `DescribeGameServerInstances` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/fleetiqguide/reference-awssdk-fleetiq.html)
  """
  def suspend_game_server_group(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "SuspendGameServerGroup", input, options)
  end

  @doc """
  Assigns a tag to a GameLift resource.

  AWS resource tags provide an additional management tool set. You can use tags to
  organize resources, create IAM permissions policies to manage access to groups
  of resources, customize AWS cost breakdowns, etc. This operation handles the
  permissions necessary to manage tags for the following GameLift resource types:

    * Build

    * Script

    * Fleet

    * Alias

    * GameSessionQueue

    * MatchmakingConfiguration

    * MatchmakingRuleSet

  To add a tag to a resource, specify the unique ARN value for the resource and
  provide a tag list containing one or more tags. The operation succeeds even if
  the list includes tags that are already assigned to the specified resource.

  ## Learn more

  [Tagging AWS Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html) in
  the *AWS General Reference*

  [ AWS Tagging Strategies](http://aws.amazon.com/answers/account-management/aws-tagging-strategies/)

  ## Related actions

  `TagResource` | `UntagResource` | `ListTagsForResource` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def tag_resource(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "TagResource", input, options)
  end

  @doc """
  Removes a tag that is assigned to a GameLift resource.

  Resource tags are used to organize AWS resources for a range of purposes. This
  operation handles the permissions necessary to manage tags for the following
  GameLift resource types:

    * Build

    * Script

    * Fleet

    * Alias

    * GameSessionQueue

    * MatchmakingConfiguration

    * MatchmakingRuleSet

  To remove a tag from a resource, specify the unique ARN value for the resource
  and provide a string list containing one or more tags to be removed. This
  operation succeeds even if the list includes tags that are not currently
  assigned to the specified resource.

  ## Learn more

  [Tagging AWS Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html) in
  the *AWS General Reference*

  [ AWS Tagging Strategies](http://aws.amazon.com/answers/account-management/aws-tagging-strategies/)

  ## Related actions

  `TagResource` | `UntagResource` | `ListTagsForResource` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def untag_resource(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "UntagResource", input, options)
  end

  @doc """
  Updates properties for an alias.

  To update properties, specify the alias ID to be updated and provide the
  information to be changed. To reassign an alias to another fleet, provide an
  updated routing strategy. If successful, the updated alias record is returned.

  ## Related actions

  `CreateAlias` | `ListAliases` | `DescribeAlias` | `UpdateAlias` | `DeleteAlias`
  | `ResolveAlias` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def update_alias(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "UpdateAlias", input, options)
  end

  @doc """
  Updates metadata in a build resource, including the build name and version.

  To update the metadata, specify the build ID to update and provide the new
  values. If successful, a build object containing the updated metadata is
  returned.

  ## Learn more

  [ Upload a Custom Server Build](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-build-intro.html)

  ## Related actions

  `CreateBuild` | `ListBuilds` | `DescribeBuild` | `UpdateBuild` | `DeleteBuild` |
  [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def update_build(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "UpdateBuild", input, options)
  end

  @doc """
  Updates a fleet's mutable attributes, including game session protection and
  resource creation limits.

  To update fleet attributes, specify the fleet ID and the property values that
  you want to change.

  If successful, an updated `FleetAttributes` object is returned.

  ## Learn more

  [Setting up GameLift fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-intro.html)

  ## Related actions

  `CreateFleetLocations` | `UpdateFleetAttributes` | `UpdateFleetCapacity` |
  `UpdateFleetPortSettings` | `UpdateRuntimeConfiguration` | `StopFleetActions` |
  `StartFleetActions` | `PutScalingPolicy` | `DeleteFleet` |
  `DeleteFleetLocations` | `DeleteScalingPolicy` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def update_fleet_attributes(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "UpdateFleetAttributes", input, options)
  end

  @doc """
  Updates capacity settings for a fleet.

  For fleets with multiple locations, use this operation to manage capacity
  settings in each location individually. Fleet capacity determines the number of
  game sessions and players that can be hosted based on the fleet configuration.
  Use this operation to set the following fleet capacity properties:

    * Minimum/maximum size: Set hard limits on fleet capacity. GameLift
  cannot set the fleet's capacity to a value outside of this range, whether the
  capacity is changed manually or through automatic scaling.

    * Desired capacity: Manually set the number of EC2 instances to be
  maintained in a fleet location. Before changing a fleet's desired capacity, you
  may want to call `DescribeEC2InstanceLimits` to get the maximum capacity of the
  fleet's EC2 instance type. Alternatively, consider using automatic scaling to
  adjust capacity based on player demand.

  This operation can be used in the following ways:

    * To update capacity for a fleet's home Region, or if the fleet has
  no remote locations, omit the `Location` parameter. The fleet must be in
  `ACTIVE` status.

    * To update capacity for a fleet's remote location, include the
  `Location` parameter set to the location to be updated. The location must be in
  `ACTIVE` status.

  If successful, capacity settings are updated immediately. In response a change
  in desired capacity, GameLift initiates steps to start new instances or
  terminate existing instances in the requested fleet location. This continues
  until the location's active instance count matches the new desired instance
  count. You can track a fleet's current capacity by calling
  `DescribeFleetCapacity` or `DescribeFleetLocationCapacity`. If the requested
  desired instance count is higher than the instance type's limit, the
  `LimitExceeded` exception occurs.

  ## Learn more

  [Scaling fleet capacity](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-manage-capacity.html)

  ## Related actions

  `CreateFleetLocations` | `UpdateFleetAttributes` | `UpdateFleetCapacity` |
  `UpdateFleetPortSettings` | `UpdateRuntimeConfiguration` | `StopFleetActions` |
  `StartFleetActions` | `PutScalingPolicy` | `DeleteFleet` |
  `DeleteFleetLocations` | `DeleteScalingPolicy` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def update_fleet_capacity(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "UpdateFleetCapacity", input, options)
  end

  @doc """
  Updates permissions that allow inbound traffic to connect to game sessions that
  are being hosted on instances in the fleet.

  To update settings, specify the fleet ID to be updated and specify the changes
  to be made. List the permissions you want to add in
  `InboundPermissionAuthorizations`, and permissions you want to remove in
  `InboundPermissionRevocations`. Permissions to be removed must match existing
  fleet permissions.

  If successful, the fleet ID for the updated fleet is returned. For fleets with
  remote locations, port setting updates can take time to propagate across all
  locations. You can check the status of updates in each location by calling
  `DescribeFleetPortSettings` with a location name.

  ## Learn more

  [Setting up GameLift fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-intro.html)

  ## Related actions

  `CreateFleetLocations` | `UpdateFleetAttributes` | `UpdateFleetCapacity` |
  `UpdateFleetPortSettings` | `UpdateRuntimeConfiguration` | `StopFleetActions` |
  `StartFleetActions` | `PutScalingPolicy` | `DeleteFleet` |
  `DeleteFleetLocations` | `DeleteScalingPolicy` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def update_fleet_port_settings(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "UpdateFleetPortSettings", input, options)
  end

  @doc """
  ## This operation is used with the GameLift FleetIQ solution and game server
  groups.

  Updates information about a registered game server to help GameLift FleetIQ to
  track game server availability.

  This operation is called by a game server process that is running on an instance
  in a game server group.

  Use this operation to update the following types of game server information. You
  can make all three types of updates in the same request:

    * To update the game server's utilization status, identify the game
  server and game server group and specify the current utilization status. Use
  this status to identify when game servers are currently hosting games and when
  they are available to be claimed.

    * To report health status, identify the game server and game server
  group and set health check to `HEALTHY`. If a game server does not report health
  status for a certain length of time, the game server is no longer considered
  healthy. As a result, it will be eventually deregistered from the game server
  group to avoid affecting utilization metrics. The best practice is to report
  health every 60 seconds.

    * To change game server metadata, provide updated game server data.

  Once a game server is successfully updated, the relevant statuses and timestamps
  are updated.

  ## Learn more

  [GameLift FleetIQ Guide](https://docs.aws.amazon.com/gamelift/latest/fleetiqguide/gsg-intro.html)

  ## Related actions

  `RegisterGameServer` | `ListGameServers` | `ClaimGameServer` |
  `DescribeGameServer` | `UpdateGameServer` | `DeregisterGameServer` | [All APIs by
  task](https://docs.aws.amazon.com/gamelift/latest/fleetiqguide/reference-awssdk-fleetiq.html)
  """
  def update_game_server(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "UpdateGameServer", input, options)
  end

  @doc """
  ## This operation is used with the GameLift FleetIQ solution and game server
  groups.

  Updates GameLift FleetIQ-specific properties for a game server group.

  Many Auto Scaling group properties are updated on the Auto Scaling group
  directly, including the launch template, Auto Scaling policies, and
  maximum/minimum/desired instance counts.

  To update the game server group, specify the game server group ID and provide
  the updated values. Before applying the updates, the new values are validated to
  ensure that GameLift FleetIQ can continue to perform instance balancing
  activity. If successful, a `GameServerGroup` object is returned.

  ## Learn more

  [GameLift FleetIQ Guide](https://docs.aws.amazon.com/gamelift/latest/fleetiqguide/gsg-intro.html)

  ## Related actions

  `CreateGameServerGroup` | `ListGameServerGroups` | `DescribeGameServerGroup` |
  `UpdateGameServerGroup` | `DeleteGameServerGroup` | `ResumeGameServerGroup` |
  `SuspendGameServerGroup` | `DescribeGameServerInstances` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/fleetiqguide/reference-awssdk-fleetiq.html)
  """
  def update_game_server_group(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "UpdateGameServerGroup", input, options)
  end

  @doc """
  Updates the mutable properties of a game session.

  To update a game session, specify the game session ID and the values you want to
  change.

  If successful, the updated `GameSession` object is returned.

  ## Related actions

  `CreateGameSession` | `DescribeGameSessions` | `DescribeGameSessionDetails` |
  `SearchGameSessions` | `UpdateGameSession` | `GetGameSessionLogUrl` |
  `StartGameSessionPlacement` | `DescribeGameSessionPlacement` |
  `StopGameSessionPlacement` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def update_game_session(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "UpdateGameSession", input, options)
  end

  @doc """
  Updates the configuration of a game session queue, which determines how the
  queue processes new game session requests.

  To update settings, specify the queue name to be updated and provide the new
  settings. When updating destinations, provide a complete list of destinations.

  ## Learn more

  [ Using Multi-Region Queues](https://docs.aws.amazon.com/gamelift/latest/developerguide/queues-intro.html)

  ## Related actions

  `CreateGameSessionQueue` | `DescribeGameSessionQueues` |
  `UpdateGameSessionQueue` | `DeleteGameSessionQueue` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def update_game_session_queue(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "UpdateGameSessionQueue", input, options)
  end

  @doc """
  Updates settings for a FlexMatch matchmaking configuration.

  These changes affect all matches and game sessions that are created after the
  update. To update settings, specify the configuration name to be updated and
  provide the new settings.

  ## Learn more

  [ Design a FlexMatch matchmaker](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/match-configuration.html)

  ## Related actions

  `CreateMatchmakingConfiguration` | `DescribeMatchmakingConfigurations` |
  `UpdateMatchmakingConfiguration` | `DeleteMatchmakingConfiguration` |
  `CreateMatchmakingRuleSet` | `DescribeMatchmakingRuleSets` |
  `ValidateMatchmakingRuleSet` | `DeleteMatchmakingRuleSet` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def update_matchmaking_configuration(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "UpdateMatchmakingConfiguration", input, options)
  end

  @doc """
  Updates the current runtime configuration for the specified fleet, which tells
  GameLift how to launch server processes on all instances in the fleet.

  You can update a fleet's runtime configuration at any time after the fleet is
  created; it does not need to be in `ACTIVE` status.

  To update runtime configuration, specify the fleet ID and provide a
  `RuntimeConfiguration` with an updated set of server process configurations.

  If successful, the fleet's runtime configuration settings are updated. Each
  instance in the fleet regularly checks for and retrieves updated runtime
  configurations. Instances immediately begin complying with the new configuration
  by launching new server processes or not replacing existing processes when they
  shut down. Updating a fleet's runtime configuration never affects existing
  server processes.

  ## Learn more

  [Setting up GameLift fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-intro.html)

  ## Related actions

  `CreateFleetLocations` | `UpdateFleetAttributes` | `UpdateFleetCapacity` |
  `UpdateFleetPortSettings` | `UpdateRuntimeConfiguration` | `StopFleetActions` |
  `StartFleetActions` | `PutScalingPolicy` | `DeleteFleet` |
  `DeleteFleetLocations` | `DeleteScalingPolicy` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def update_runtime_configuration(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "UpdateRuntimeConfiguration", input, options)
  end

  @doc """
  Updates Realtime script metadata and content.

  To update script metadata, specify the script ID and provide updated name and/or
  version values.

  To update script content, provide an updated zip file by pointing to either a
  local file or an Amazon S3 bucket location. You can use either method regardless
  of how the original script was uploaded. Use the *Version* parameter to track
  updates to the script.

  If the call is successful, the updated metadata is stored in the script record
  and a revised script is uploaded to the Amazon GameLift service. Once the script
  is updated and acquired by a fleet instance, the new version is used for all new
  game sessions.

  ## Learn more

  [Amazon GameLift Realtime Servers](https://docs.aws.amazon.com/gamelift/latest/developerguide/realtime-intro.html)

  ## Related actions

  `CreateScript` | `ListScripts` | `DescribeScript` | `UpdateScript` |
  `DeleteScript` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def update_script(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "UpdateScript", input, options)
  end

  @doc """
  Validates the syntax of a matchmaking rule or rule set.

  This operation checks that the rule set is using syntactically correct JSON and
  that it conforms to allowed property expressions. To validate syntax, provide a
  rule set JSON string.

  ## Learn more

    * [Build a rule set](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/match-rulesets.html)

  ## Related actions

  `CreateMatchmakingConfiguration` | `DescribeMatchmakingConfigurations` |
  `UpdateMatchmakingConfiguration` | `DeleteMatchmakingConfiguration` |
  `CreateMatchmakingRuleSet` | `DescribeMatchmakingRuleSets` |
  `ValidateMatchmakingRuleSet` | `DeleteMatchmakingRuleSet` | [All APIs by task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
  """
  def validate_matchmaking_rule_set(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "ValidateMatchmakingRuleSet", input, options)
  end
end
