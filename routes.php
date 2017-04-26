<?php

ini_set('display_errors', 'On');
error_reporting(E_ALL);

//test
$app->get('/test', function ($request, $response, $args) {
	echo "kill me.";
});

/////CHANNELS/////

// get all channels
$app->get('/channels', function ($request, $response, $args) {
     $sth = $this->db->prepare("SELECT * FROM Channels ORDER BY channel_id");
    $sth->execute();
    $chan = $sth->fetchAll();
    return $this->response->withJson($chan);
});

// get channel by id
$app->get('/channels/[{id}]', function ($request, $response, $args) {
     $sth = $this->db->prepare("SELECT * FROM Channels WHERE channel_id=:id");
    $sth->bindParam("id", $args['id']);
    $sth->execute();
    $chan = $sth->fetchObject();
    return $this->response->withJson($chan);
});

// Search channels by keywords
$app->get('/channels/search/[{query}]', function ($request, $response, $args) {
     $sth = $this->db->prepare("SELECT * FROM Channels WHERE UPPER(channel_name) LIKE :query ORDER BY channel_name");
    $query = "%".$args['query']."%";
    $sth->bindParam("query", $query);
    $sth->execute();
    $chan = $sth->fetchAll();
    return $this->response->withJson($chan);
});


/////DEBATES/////

//get all debates
$app->get('/debates', function ($request, $response, $args) {
	$sth = $this->db->prepare("SELECT * FROM Debates ORDER BY debate_name ASC");
	$sth->execute();
	$debates = $sth->fetchAll();
	return $this->response->withJson($debates);
});

//get all debates within a channel id -> rewrite in inner SQL to have it by channel name
$app->get('/debates/channel/[{channel}]', function ($request, $response, $args) {
     $sth = $this->db->prepare("SELECT * FROM Debates WHERE debate_channel=:channel");
    $sth->bindParam("channel", $args['channel']);
    $sth->execute();
    $debates = $sth->fetchObject();
    return $this->response->withJson($debates);
});

//get debates by state
$app->get('/debates/state/[{state}]', function ($request, $response, $args) {
     $sth = $this->db->prepare("SELECT * FROM Debates WHERE debate_state=:state");
    $sth->bindParam("state", $args['state']);
    $sth->execute();
    $debates = $sth->fetchObject();
    return $this->response->withJson($debates);
});


//get debates by id
$app->get('/debates/[{id}]', function ($request, $response, $args)  {
	$sth = $this->db->prepare("SELECT * FROM Debates WHERE debate_id=:id");
	$sth->bindParam("id", $args['id']);
	$sth->execute();
	$debates = $sth->fetchObject();
	return $this->response->withJson($debates);
});

//search for debates with search term in the name
$app->get('/debates/search/[{query}]', function($request, $response, $args) {
	$sth = $this->db->prepare("SELECT * FROM Debates WHERE UPPER(debate_name) LIKE :query ORDER BY debate_name");
	$query = "%".$args['query']."%";
	$sth->bindParam("query", $query);
	$sth->execute();
	$debates = $sth->fetchAll();
	return $this->response->withJson($debates);
});


////USERS/////

//get all users -> change phone number param to varchar(10) from int(10)
$app->get('/users', function ($request, $response, $args) {
	$sth = $this->db->prepare("SELECT * FROM Users ORDER BY user_id ASC");
	$sth->execute();
	$users = $sth->fetchAll();
	return $this->response->withJson($users);
});

//get users by id
$app->get('/users/[{id}]', function ($request, $response, $args) {
     $sth = $this->db->prepare("SELECT * FROM Users WHERE user_id=:id");
    $sth->bindParam("id", $args['id']);
    $sth->execute();
    $users = $sth->fetchObject();
    return $this->response->withJson($users);
});

// Search users by username
$app->get('/users/search/username/[{query}]', function ($request, $response, $args) {
     $sth = $this->db->prepare("SELECT * FROM Users WHERE UPPER(username) LIKE :query ORDER BY username");
    $query = "%".$args['query']."%";
    $sth->bindParam("query", $query);
    $sth->execute();
    $users = $sth->fetchAll();
    return $this->response->withJson($users);
});

//search users by email
$app->get('/users/search/email/[{query}]', function ($request, $response, $args) {
     $sth = $this->db->prepare("SELECT * FROM Users WHERE UPPER(email) LIKE :query ORDER BY email");
    $query = "%".$args['query']."%";
    $sth->bindParam("query", $query);
    $sth->execute();
    $users = $sth->fetchAll();
    return $this->response->withJson($users);
});

?>
