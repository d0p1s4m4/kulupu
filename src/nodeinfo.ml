type link = { rel : string; href : string } [@@deriving yojson_of]
type links = { links : link list } [@@deriving yojson_of]

type software = {
  name : string;
  version : string;
  repository : string option; [@yojson.option]
  homepage : string option; [@yojson.option]
}
[@@deriving yojson_of]

type services = { outbound : string list; inbound : string list }
[@@deriving yojson_of]

type users = { total : int; activeHalfyear : int; activeMonth : int }
[@@deriving yojson_of]

type usage = { users : users; localPosts : int; localComments : int }
[@@deriving yojson_of]

type nodeinfo = {
  version : string;
  software : software;
  protocols : string list;
  services : services;
  openRegistrations : bool;
  usage : usage;
  metadata : string list;
}
[@@deriving yojson_of]

let nodeinfo2_0 =
  {
    version = "2.0";
    software =
      {
        name = "kulupu";
        version = "@@VERSION@@";
        repository = None;
        homepage = None;
      };
    protocols = [ "activitypub" ];
    services = { outbound = []; inbound = [] };
    openRegistrations = false;
    usage =
      {
        users = { total = 0; activeHalfyear = 0; activeMonth = 0 };
        localPosts = 0;
        localComments = 0;
      };
    metadata = [];
  }

let get _ =
  yojson_of_links
    {
      links =
        [
          {
            rel = "http://nodeinfo.diaspora.software/ns/schema/2.1";
            href = "http://localhost:8080/nodeinfo/2.1";
          };
          {
            rel = "http://nodeinfo.diaspora.software/ns/schema/2.0";
            href = "http://localhost:8080/nodeinfo/2.0";
          };
        ];
    }
  |> Yojson.Safe.to_string |> Dream.json

let get_2_0 _ =
  yojson_of_nodeinfo nodeinfo2_0 |> Yojson.Safe.to_string |> Dream.json

let get_2_1 _ =
  let repo = "https://github.com/d0p1s4m4/kulupu" in
  let info = nodeinfo2_0 in
  yojson_of_nodeinfo
    {
      info with
      version = "2.1";
      software =
        { info.software with repository = Some repo; homepage = Some repo };
    }
  |> Yojson.Safe.to_string |> Dream.json

let route =
  Dream.scope "/nodeinfo" []
    [ Dream.get "/2.1" get_2_1; Dream.get "/2.0" get_2_0 ]
