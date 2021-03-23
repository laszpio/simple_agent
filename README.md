# ActiveWorkflow Agent Example in Elixir

This project implements a simple example agent for [ActiveWorkflow](https://github.com/automaticmode/active_workflow).
The agent is implemented in Elixir and uses the [remote agent API](https://docs.activeworkflow.org/remote-agent-api).

This agent doesn't do anything particularly useful but demonstrates some of the
features of ActiveWorkflow's Remote Agent API. The agent simply records the the
number of `check` and `receive` calls it sees in memory and returns messages
with the current count.

## Quick Start

This agent is intended to be used as part of [ActiveWorkflow](https://github.com/automaticmode/active_workflow).
To get started with ActiveWorkflow please see the [ActiveWorkflow documentation](https://docs.activeworkflow.org/).

Please make sure you run this agent *before* starting ActiveWorkflow.  The
agent can be started like this:

```sh
mix run --no-halt
```

Note the URL of the agent's server (usually `http://127.0.0.1:5000/`), and use
it as an environment variable for ActiveWorkflow:

```sh
export REMOTE_AGENT_URL="http://127.0.0.1:5000/"
```

Now you can start ActiveWorkflow. You should be able to create instances of
this agent (named "Simple Elixir Agent"). Run it and send messages to it.

If using Docker to run ActiveWorkflow, you'll need to use the `-e` parameter to
`docker run` to pass `REMOTE_AGENT_URL` through to ActiveWorkflow. The address
in the URL will also have to be updated to match where the agent is running
(`127.0.0.1` is unlikely to be correct).

Please note that this project is just a minimal example. Consider using a
proper project structure when developing your own ActiveWorkflow agents.
