let () =
  Dream.run @@ Dream.logger
  @@ Dream.router
       ([ Dream.scope "/.well-known" [] [ Dream.get "/nodeinfo" Nodeinfo.get ] ]
       @ [ Nodeinfo.route ])
