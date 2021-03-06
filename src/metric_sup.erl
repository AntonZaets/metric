-module(metric_sup).
-behaviour(supervisor).
%% Supervisor callbacks
-export([init/1]).
%% Supervisor API
-export([start_link/0]).

%% Start main supervisior
start_link() ->
    supervisor:start_link(?MODULE, []).

init([]) ->
	MetricServerSupSpec = #{
		id => 1, 
		start => {metric_server_sup, start_link, []}, 
		restart => temporary, 
		shutdown => brutal_kill, 
		type => supervisor
	},
	MetricManagerSpec = #{
		id => 2,
		start => {metric_manager, start_link, []},
		restart => permanent,
		shutdown => brutal_kill,
		type => worker
	},
    {ok, {{one_for_all, 1, 5}, [MetricServerSupSpec, MetricManagerSpec]}}.
