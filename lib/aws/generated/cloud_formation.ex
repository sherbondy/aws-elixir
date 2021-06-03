# WARNING: DO NOT EDIT, AUTO-GENERATED CODE!
# See https://github.com/aws-beam/aws-codegen for more details.

defmodule AWS.CloudFormation do
  @moduledoc """
  AWS CloudFormation

  AWS CloudFormation allows you to create and manage AWS infrastructure
  deployments predictably and repeatedly.

  You can use AWS CloudFormation to leverage AWS products, such as Amazon Elastic
  Compute Cloud, Amazon Elastic Block Store, Amazon Simple Notification Service,
  Elastic Load Balancing, and Auto Scaling to build highly-reliable, highly
  scalable, cost-effective applications without creating or configuring the
  underlying AWS infrastructure.

  With AWS CloudFormation, you declare all of your resources and dependencies in a
  template file. The template defines a collection of resources as a single unit
  called a stack. AWS CloudFormation creates and deletes all member resources of
  the stack together and manages all dependencies between the resources for you.

  For more information about AWS CloudFormation, see the [AWS CloudFormation Product Page](http://aws.amazon.com/cloudformation/).

  Amazon CloudFormation makes use of other AWS products. If you need additional
  technical information about a specific AWS product, you can find the product's
  technical documentation at [docs.aws.amazon.com](https://docs.aws.amazon.com/).
  """

  alias AWS.Client
  alias AWS.Request

  def metadata do
    %AWS.ServiceMetadata{
      abbreviation: nil,
      api_version: "2010-05-15",
      content_type: "application/x-www-form-urlencoded",
      credential_scope: nil,
      endpoint_prefix: "cloudformation",
      global?: false,
      protocol: "query",
      service_id: "CloudFormation",
      signature_version: "v4",
      signing_name: "cloudformation",
      target_prefix: nil
    }
  end

  @doc """
  Cancels an update on the specified stack.

  If the call completes successfully, the stack rolls back the update and reverts
  to the previous stack configuration.

  You can cancel only stacks that are in the UPDATE_IN_PROGRESS state.
  """
  def cancel_update_stack(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "CancelUpdateStack", input, options)
  end

  @doc """
  For a specified stack that is in the `UPDATE_ROLLBACK_FAILED` state, continues
  rolling it back to the `UPDATE_ROLLBACK_COMPLETE` state.

  Depending on the cause of the failure, you can manually [ fix the error](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/troubleshooting.html#troubleshooting-errors-update-rollback-failed)
  and continue the rollback. By continuing the rollback, you can return your stack
  to a working state (the `UPDATE_ROLLBACK_COMPLETE` state), and then try to
  update the stack again.

  A stack goes into the `UPDATE_ROLLBACK_FAILED` state when AWS CloudFormation
  cannot roll back all changes after a failed stack update. For example, you might
  have a stack that is rolling back to an old database instance that was deleted
  outside of AWS CloudFormation. Because AWS CloudFormation doesn't know the
  database was deleted, it assumes that the database instance still exists and
  attempts to roll back to it, causing the update rollback to fail.
  """
  def continue_update_rollback(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "ContinueUpdateRollback", input, options)
  end

  @doc """
  Creates a list of changes that will be applied to a stack so that you can review
  the changes before executing them.

  You can create a change set for a stack that doesn't exist or an existing stack.
  If you create a change set for a stack that doesn't exist, the change set shows
  all of the resources that AWS CloudFormation will create. If you create a change
  set for an existing stack, AWS CloudFormation compares the stack's information
  with the information that you submit in the change set and lists the
  differences. Use change sets to understand which resources AWS CloudFormation
  will create or change, and how it will change resources in an existing stack,
  before you create or update a stack.

  To create a change set for a stack that doesn't exist, for the `ChangeSetType`
  parameter, specify `CREATE`. To create a change set for an existing stack,
  specify `UPDATE` for the `ChangeSetType` parameter. To create a change set for
  an import operation, specify `IMPORT` for the `ChangeSetType` parameter. After
  the `CreateChangeSet` call successfully completes, AWS CloudFormation starts
  creating the change set. To check the status of the change set or to review it,
  use the `DescribeChangeSet` action.

  When you are satisfied with the changes the change set will make, execute the
  change set by using the `ExecuteChangeSet` action. AWS CloudFormation doesn't
  make changes until you execute the change set.

  To create a change set for the entire stack hierachy, set `IncludeNestedStacks`
  to `True`.
  """
  def create_change_set(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "CreateChangeSet", input, options)
  end

  @doc """
  Creates a stack as specified in the template.

  After the call completes successfully, the stack creation starts. You can check
  the status of the stack via the `DescribeStacks` API.
  """
  def create_stack(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "CreateStack", input, options)
  end

  @doc """
  Creates stack instances for the specified accounts, within the specified
  Regions.

  A stack instance refers to a stack in a specific account and Region. You must
  specify at least one value for either `Accounts` or `DeploymentTargets`, and you
  must specify at least one value for `Regions`.
  """
  def create_stack_instances(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "CreateStackInstances", input, options)
  end

  @doc """
  Creates a stack set.
  """
  def create_stack_set(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "CreateStackSet", input, options)
  end

  @doc """
  Deletes the specified change set.

  Deleting change sets ensures that no one executes the wrong change set.

  If the call successfully completes, AWS CloudFormation successfully deleted the
  change set.

  If `IncludeNestedStacks` specifies `True` during the creation of the nested
  change set, then `DeleteChangeSet` will delete all change sets that belong to
  the stacks hierarchy and will also delete all change sets for nested stacks with
  the status of `REVIEW_IN_PROGRESS`.
  """
  def delete_change_set(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DeleteChangeSet", input, options)
  end

  @doc """
  Deletes a specified stack.

  Once the call completes successfully, stack deletion starts. Deleted stacks do
  not show up in the `DescribeStacks` API if the deletion has been completed
  successfully.
  """
  def delete_stack(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DeleteStack", input, options)
  end

  @doc """
  Deletes stack instances for the specified accounts, in the specified Regions.
  """
  def delete_stack_instances(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DeleteStackInstances", input, options)
  end

  @doc """
  Deletes a stack set.

  Before you can delete a stack set, all of its member stack instances must be
  deleted. For more information about how to do this, see `DeleteStackInstances`.
  """
  def delete_stack_set(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DeleteStackSet", input, options)
  end

  @doc """
  Marks an extension or extension version as `DEPRECATED` in the CloudFormation
  registry, removing it from active use.

  Deprecated extensions or extension versions cannot be used in CloudFormation
  operations.

  To deregister an entire extension, you must individually deregister all active
  versions of that extension. If an extension has only a single active version,
  deregistering that version results in the extension itself being deregistered
  and marked as deprecated in the registry.

  You cannot deregister the default version of an extension if there are other
  active version of that extension. If you do deregister the default version of an
  extension, the textensionype itself is deregistered as well and marked as
  deprecated.

  To view the deprecation status of an extension or extension version, use
  [DescribeType](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_DescribeType.html).
  """
  def deregister_type(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DeregisterType", input, options)
  end

  @doc """
  Retrieves your account's AWS CloudFormation limits, such as the maximum number
  of stacks that you can create in your account.

  For more information about account limits, see [AWS CloudFormation Limits](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cloudformation-limits.html)
  in the *AWS CloudFormation User Guide*.
  """
  def describe_account_limits(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeAccountLimits", input, options)
  end

  @doc """
  Returns the inputs for the change set and a list of changes that AWS
  CloudFormation will make if you execute the change set.

  For more information, see [Updating Stacks Using Change Sets](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-updating-stacks-changesets.html)
  in the AWS CloudFormation User Guide.
  """
  def describe_change_set(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeChangeSet", input, options)
  end

  @doc """
  Returns information about a stack drift detection operation.

  A stack drift detection operation detects whether a stack's actual configuration
  differs, or has *drifted*, from it's expected configuration, as defined in the
  stack template and any values specified as template parameters. A stack is
  considered to have drifted if one or more of its resources have drifted. For
  more information on stack and resource drift, see [Detecting Unregulated Configuration Changes to Stacks and
  Resources](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift.html).

  Use `DetectStackDrift` to initiate a stack drift detection operation.
  `DetectStackDrift` returns a `StackDriftDetectionId` you can use to monitor the
  progress of the operation using `DescribeStackDriftDetectionStatus`. Once the
  drift detection operation has completed, use `DescribeStackResourceDrifts` to
  return drift information about the stack and its resources.
  """
  def describe_stack_drift_detection_status(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeStackDriftDetectionStatus", input, options)
  end

  @doc """
  Returns all stack related events for a specified stack in reverse chronological
  order.

  For more information about a stack's event history, go to
  [Stacks](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/concept-stack.html)
  in the AWS CloudFormation User Guide.

  You can list events for stacks that have failed to create or have been deleted
  by specifying the unique stack identifier (stack ID).
  """
  def describe_stack_events(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeStackEvents", input, options)
  end

  @doc """
  Returns the stack instance that's associated with the specified stack set, AWS
  account, and Region.

  For a list of stack instances that are associated with a specific stack set, use
  `ListStackInstances`.
  """
  def describe_stack_instance(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeStackInstance", input, options)
  end

  @doc """
  Returns a description of the specified resource in the specified stack.

  For deleted stacks, DescribeStackResource returns resource information for up to
  90 days after the stack has been deleted.
  """
  def describe_stack_resource(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeStackResource", input, options)
  end

  @doc """
  Returns drift information for the resources that have been checked for drift in
  the specified stack.

  This includes actual and expected configuration values for resources where AWS
  CloudFormation detects configuration drift.

  For a given stack, there will be one `StackResourceDrift` for each stack
  resource that has been checked for drift. Resources that have not yet been
  checked for drift are not included. Resources that do not currently support
  drift detection are not checked, and so not included. For a list of resources
  that support drift detection, see [Resources that Support Drift Detection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift-resource-list.html).

  Use `DetectStackResourceDrift` to detect drift on individual resources, or
  `DetectStackDrift` to detect drift on all supported resources for a given stack.
  """
  def describe_stack_resource_drifts(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeStackResourceDrifts", input, options)
  end

  @doc """
  Returns AWS resource descriptions for running and deleted stacks.

  If `StackName` is specified, all the associated resources that are part of the
  stack are returned. If `PhysicalResourceId` is specified, the associated
  resources of the stack that the resource belongs to are returned.

  Only the first 100 resources will be returned. If your stack has more resources
  than this, you should use `ListStackResources` instead.

  For deleted stacks, `DescribeStackResources` returns resource information for up
  to 90 days after the stack has been deleted.

  You must specify either `StackName` or `PhysicalResourceId`, but not both. In
  addition, you can specify `LogicalResourceId` to filter the returned result. For
  more information about resources, the `LogicalResourceId` and
  `PhysicalResourceId`, go to the [AWS CloudFormation User Guide](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/).

  A `ValidationError` is returned if you specify both `StackName` and
  `PhysicalResourceId` in the same request.
  """
  def describe_stack_resources(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeStackResources", input, options)
  end

  @doc """
  Returns the description of the specified stack set.
  """
  def describe_stack_set(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeStackSet", input, options)
  end

  @doc """
  Returns the description of the specified stack set operation.
  """
  def describe_stack_set_operation(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeStackSetOperation", input, options)
  end

  @doc """
  Returns the description for the specified stack; if no stack name was specified,
  then it returns the description for all the stacks created.

  If the stack does not exist, an `AmazonCloudFormationException` is returned.
  """
  def describe_stacks(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeStacks", input, options)
  end

  @doc """
  Returns detailed information about an extension that has been registered.

  If you specify a `VersionId`, `DescribeType` returns information about that
  specific extension version. Otherwise, it returns information about the default
  extension version.
  """
  def describe_type(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeType", input, options)
  end

  @doc """
  Returns information about an extension's registration, including its current
  status and type and version identifiers.

  When you initiate a registration request using ` `RegisterType` `, you can then
  use ` `DescribeTypeRegistration` ` to monitor the progress of that registration
  request.

  Once the registration request has completed, use ` `DescribeType` ` to return
  detailed information about an extension.
  """
  def describe_type_registration(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DescribeTypeRegistration", input, options)
  end

  @doc """
  Detects whether a stack's actual configuration differs, or has *drifted*, from
  it's expected configuration, as defined in the stack template and any values
  specified as template parameters.

  For each resource in the stack that supports drift detection, AWS CloudFormation
  compares the actual configuration of the resource with its expected template
  configuration. Only resource properties explicitly defined in the stack template
  are checked for drift. A stack is considered to have drifted if one or more of
  its resources differ from their expected template configurations. For more
  information, see [Detecting Unregulated Configuration Changes to Stacks and Resources](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift.html).

  Use `DetectStackDrift` to detect drift on all supported resources for a given
  stack, or `DetectStackResourceDrift` to detect drift on individual resources.

  For a list of stack resources that currently support drift detection, see
  [Resources that Support Drift Detection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift-resource-list.html).

  `DetectStackDrift` can take up to several minutes, depending on the number of
  resources contained within the stack. Use `DescribeStackDriftDetectionStatus` to
  monitor the progress of a detect stack drift operation. Once the drift detection
  operation has completed, use `DescribeStackResourceDrifts` to return drift
  information about the stack and its resources.

  When detecting drift on a stack, AWS CloudFormation does not detect drift on any
  nested stacks belonging to that stack. Perform `DetectStackDrift` directly on
  the nested stack itself.
  """
  def detect_stack_drift(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DetectStackDrift", input, options)
  end

  @doc """
  Returns information about whether a resource's actual configuration differs, or
  has *drifted*, from it's expected configuration, as defined in the stack
  template and any values specified as template parameters.

  This information includes actual and expected property values for resources in
  which AWS CloudFormation detects drift. Only resource properties explicitly
  defined in the stack template are checked for drift. For more information about
  stack and resource drift, see [Detecting Unregulated Configuration Changes to Stacks and
  Resources](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift.html).

  Use `DetectStackResourceDrift` to detect drift on individual resources, or
  `DetectStackDrift` to detect drift on all resources in a given stack that
  support drift detection.

  Resources that do not currently support drift detection cannot be checked. For a
  list of resources that support drift detection, see [Resources that Support Drift
  Detection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift-resource-list.html).
  """
  def detect_stack_resource_drift(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DetectStackResourceDrift", input, options)
  end

  @doc """
  Detect drift on a stack set.

  When CloudFormation performs drift detection on a stack set, it performs drift
  detection on the stack associated with each stack instance in the stack set. For
  more information, see [How CloudFormation Performs Drift Detection on a Stack Set](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-drift.html).

  `DetectStackSetDrift` returns the `OperationId` of the stack set drift detection
  operation. Use this operation id with ` `DescribeStackSetOperation` ` to monitor
  the progress of the drift detection operation. The drift detection operation may
  take some time, depending on the number of stack instances included in the stack
  set, as well as the number of resources included in each stack.

  Once the operation has completed, use the following actions to return drift
  information:

    * Use ` `DescribeStackSet` ` to return detailed information about
  the stack set, including detailed information about the last *completed* drift
  operation performed on the stack set. (Information about drift operations that
  are in progress is not included.)

    * Use ` `ListStackInstances` ` to return a list of stack instances
  belonging to the stack set, including the drift status and last drift time
  checked of each instance.

    * Use ` `DescribeStackInstance` ` to return detailed information
  about a specific stack instance, including its drift status and last drift time
  checked.

  For more information on performing a drift detection operation on a stack set,
  see [Detecting Unmanaged Changes in Stack Sets](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-drift.html).

  You can only run a single drift detection operation on a given stack set at one
  time.

  To stop a drift detection stack set operation, use ` `StopStackSetOperation` `.
  """
  def detect_stack_set_drift(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "DetectStackSetDrift", input, options)
  end

  @doc """
  Returns the estimated monthly cost of a template.

  The return value is an AWS Simple Monthly Calculator URL with a query string
  that describes the resources required to run the template.
  """
  def estimate_template_cost(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "EstimateTemplateCost", input, options)
  end

  @doc """
  Updates a stack using the input information that was provided when the specified
  change set was created.

  After the call successfully completes, AWS CloudFormation starts updating the
  stack. Use the `DescribeStacks` action to view the status of the update.

  When you execute a change set, AWS CloudFormation deletes all other change sets
  associated with the stack because they aren't valid for the updated stack.

  If a stack policy is associated with the stack, AWS CloudFormation enforces the
  policy during the update. You can't specify a temporary stack policy that
  overrides the current policy.

  To create a change set for the entire stack hierachy, `IncludeNestedStacks` must
  have been set to `True`.
  """
  def execute_change_set(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "ExecuteChangeSet", input, options)
  end

  @doc """
  Returns the stack policy for a specified stack.

  If a stack doesn't have a policy, a null value is returned.
  """
  def get_stack_policy(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "GetStackPolicy", input, options)
  end

  @doc """
  Returns the template body for a specified stack.

  You can get the template for running or deleted stacks.

  For deleted stacks, GetTemplate returns the template for up to 90 days after the
  stack has been deleted.

  If the template does not exist, a `ValidationError` is returned.
  """
  def get_template(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "GetTemplate", input, options)
  end

  @doc """
  Returns information about a new or existing template.

  The `GetTemplateSummary` action is useful for viewing parameter information,
  such as default parameter values and parameter types, before you create or
  update a stack or stack set.

  You can use the `GetTemplateSummary` action when you submit a template, or you
  can get template information for a stack set, or a running or deleted stack.

  For deleted stacks, `GetTemplateSummary` returns the template information for up
  to 90 days after the stack has been deleted. If the template does not exist, a
  `ValidationError` is returned.
  """
  def get_template_summary(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "GetTemplateSummary", input, options)
  end

  @doc """
  Returns the ID and status of each active change set for a stack.

  For example, AWS CloudFormation lists change sets that are in the
  `CREATE_IN_PROGRESS` or `CREATE_PENDING` state.
  """
  def list_change_sets(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "ListChangeSets", input, options)
  end

  @doc """
  Lists all exported output values in the account and Region in which you call
  this action.

  Use this action to see the exported output values that you can import into other
  stacks. To import values, use the [ `Fn::ImportValue`
  ](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference-importvalue.html)
  function.

  For more information, see [ AWS CloudFormation Export Stack Output Values](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-exports.html).
  """
  def list_exports(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "ListExports", input, options)
  end

  @doc """
  Lists all stacks that are importing an exported output value.

  To modify or remove an exported output value, first use this action to see which
  stacks are using it. To see the exported output values in your account, see
  `ListExports`.

  For more information about importing an exported output value, see the [
  `Fn::ImportValue`
  ](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference-importvalue.html)
  function.
  """
  def list_imports(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "ListImports", input, options)
  end

  @doc """
  Returns summary information about stack instances that are associated with the
  specified stack set.

  You can filter for stack instances that are associated with a specific AWS
  account name or Region, or that have a specific status.
  """
  def list_stack_instances(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "ListStackInstances", input, options)
  end

  @doc """
  Returns descriptions of all resources of the specified stack.

  For deleted stacks, ListStackResources returns resource information for up to 90
  days after the stack has been deleted.
  """
  def list_stack_resources(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "ListStackResources", input, options)
  end

  @doc """
  Returns summary information about the results of a stack set operation.
  """
  def list_stack_set_operation_results(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "ListStackSetOperationResults", input, options)
  end

  @doc """
  Returns summary information about operations performed on a stack set.
  """
  def list_stack_set_operations(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "ListStackSetOperations", input, options)
  end

  @doc """
  Returns summary information about stack sets that are associated with the user.

    * [Self-managed permissions] If you set the `CallAs` parameter to `SELF` while signed in to your AWS account, `ListStackSets` returns all
  self-managed stack sets in your AWS account.

    * [Service-managed permissions] If you set the `CallAs` parameter to
  `SELF` while signed in to the organization's management account, `ListStackSets`
  returns all stack sets in the management account.

    * [Service-managed permissions] If you set the `CallAs` parameter to
  `DELEGATED_ADMIN` while signed in to your member account, `ListStackSets`
  returns all stack sets with service-managed permissions in the management
  account.
  """
  def list_stack_sets(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "ListStackSets", input, options)
  end

  @doc """
  Returns the summary information for stacks whose status matches the specified
  StackStatusFilter.

  Summary information for stacks that have been deleted is kept for 90 days after
  the stack is deleted. If no StackStatusFilter is specified, summary information
  for all stacks is returned (including existing stacks and stacks that have been
  deleted).
  """
  def list_stacks(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "ListStacks", input, options)
  end

  @doc """
  Returns a list of registration tokens for the specified extension(s).
  """
  def list_type_registrations(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "ListTypeRegistrations", input, options)
  end

  @doc """
  Returns summary information about the versions of an extension.
  """
  def list_type_versions(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "ListTypeVersions", input, options)
  end

  @doc """
  Returns summary information about extension that have been registered with
  CloudFormation.
  """
  def list_types(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "ListTypes", input, options)
  end

  @doc """
  Reports progress of a resource handler to CloudFormation.

  Reserved for use by the [CloudFormation CLI](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/what-is-cloudformation-cli.html).
  Do not use this API in your code.
  """
  def record_handler_progress(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "RecordHandlerProgress", input, options)
  end

  @doc """
  Registers an extension with the CloudFormation service.

  Registering an extension makes it available for use in CloudFormation templates
  in your AWS account, and includes:

    * Validating the extension schema

    * Determining which handlers, if any, have been specified for the
  extension

    * Making the extension available for use in your account

  For more information on how to develop extensions and ready them for
  registeration, see [Creating Resource Providers](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/resource-types.html)
  in the *CloudFormation CLI User Guide*.

  You can have a maximum of 50 resource extension versions registered at a time.
  This maximum is per account and per region. Use
  [DeregisterType](AWSCloudFormation/latest/APIReference/API_DeregisterType.html)
  to deregister specific extension versions if necessary.

  Once you have initiated a registration request using ` `RegisterType` `, you can
  use ` `DescribeTypeRegistration` ` to monitor the progress of the registration
  request.
  """
  def register_type(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "RegisterType", input, options)
  end

  @doc """
  Sets a stack policy for a specified stack.
  """
  def set_stack_policy(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "SetStackPolicy", input, options)
  end

  @doc """
  Specify the default version of an extension.

  The default version of an extension will be used in CloudFormation operations.
  """
  def set_type_default_version(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "SetTypeDefaultVersion", input, options)
  end

  @doc """
  Sends a signal to the specified resource with a success or failure status.

  You can use the SignalResource API in conjunction with a creation policy or
  update policy. AWS CloudFormation doesn't proceed with a stack creation or
  update until resources receive the required number of signals or the timeout
  period is exceeded. The SignalResource API is useful in cases where you want to
  send signals from anywhere other than an Amazon EC2 instance.
  """
  def signal_resource(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "SignalResource", input, options)
  end

  @doc """
  Stops an in-progress operation on a stack set and its associated stack
  instances.
  """
  def stop_stack_set_operation(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "StopStackSetOperation", input, options)
  end

  @doc """
  Updates a stack as specified in the template.

  After the call completes successfully, the stack update starts. You can check
  the status of the stack via the `DescribeStacks` action.

  To get a copy of the template for an existing stack, you can use the
  `GetTemplate` action.

  For more information about creating an update template, updating a stack, and
  monitoring the progress of the update, see [Updating a Stack](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-updating-stacks.html).
  """
  def update_stack(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "UpdateStack", input, options)
  end

  @doc """
  Updates the parameter values for stack instances for the specified accounts,
  within the specified Regions.

  A stack instance refers to a stack in a specific account and Region.

  You can only update stack instances in Regions and accounts where they already
  exist; to create additional stack instances, use
  [CreateStackInstances](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_CreateStackInstances.html).  During stack set updates, any parameters overridden for a stack instance are not
  updated, but retain their overridden value.

  You can only update the parameter *values* that are specified in the stack set;
  to add or delete a parameter itself, use
  [UpdateStackSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_UpdateStackSet.html)
  to update the stack set template. If you add a parameter to a template, before
  you can override the parameter value specified in the stack set you must first
  use
  [UpdateStackSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_UpdateStackSet.html)
  to update all stack instances with the updated template and parameter value
  specified in the stack set. Once a stack instance has been updated with the new
  parameter, you can then override the parameter value using
  `UpdateStackInstances`.
  """
  def update_stack_instances(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "UpdateStackInstances", input, options)
  end

  @doc """
  Updates the stack set, and associated stack instances in the specified accounts
  and Regions.

  Even if the stack set operation created by updating the stack set fails
  (completely or partially, below or above a specified failure tolerance), the
  stack set is updated with your changes. Subsequent `CreateStackInstances` calls
  on the specified stack set use the updated stack set.
  """
  def update_stack_set(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "UpdateStackSet", input, options)
  end

  @doc """
  Updates termination protection for the specified stack.

  If a user attempts to delete a stack with termination protection enabled, the
  operation fails and the stack remains unchanged. For more information, see
  [Protecting a Stack From Being Deleted](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-protect-stacks.html)
  in the *AWS CloudFormation User Guide*.

  For [nested stacks](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-nested-stacks.html),
  termination protection is set on the root stack and cannot be changed directly
  on the nested stack.
  """
  def update_termination_protection(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "UpdateTerminationProtection", input, options)
  end

  @doc """
  Validates a specified template.

  AWS CloudFormation first checks if the template is valid JSON. If it isn't, AWS
  CloudFormation checks if the template is valid YAML. If both these checks fail,
  AWS CloudFormation returns a template validation error.
  """
  def validate_template(%Client{} = client, input, options \\ []) do
    Request.request_post(client, metadata(), "ValidateTemplate", input, options)
  end
end
