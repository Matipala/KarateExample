function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var timestamp = new Date().getTime();
  var config = {
    env: env,
    baseUrl: 'https://gorest.co.in/public/v2',
    BearerToken: 'e582c281c7b7462e01a3a05be8f93aaa4b40dda654ceb0126ba3f538b43da610',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer e582c281c7b7462e01a3a05be8f93aaa4b40dda654ceb0126ba3f538b43da610'
    },
    userName: 'Juan Carlos',
    userEmail: 'juancarlos' + timestamp + '@test.com',
    userStatus: 'active',
    userGender: 'male',
    postTitle: 'Post title ' + timestamp,
    postBody: 'Post body ' + timestamp,
    comment: 'Comment text ' + timestamp,
    todoTitle: 'Todo title ' + timestamp,
    todoStatus: 'pending',
    todoDueOn: new Date(new Date().getTime() + 3*24*60*60*1000).toISOString().split('T')[0],
    userId: null,
    postId: null,
    commentId: null,
    todoId: null
  };
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
  } else if (env == 'e2e') {
    // customize
  }
  karate.configure('ssl', {trustAll: true})
  //karate.configure('connectTimeout', {timeout: 250000})

  return config;
}