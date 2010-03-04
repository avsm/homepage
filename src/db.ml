type t = {
  bib:    (Bib.ent, [ `RO ]) Orm.Db.t;
  static: (Fs.t, [ `RO ]) Orm.Db.t;
}

let init () =
  {
    bib    = Bib.ent_init_read_only (Config.db "bib");
    static = Fs.t_init_read_only (Config.db "static");
  }

let t = init ()

let with_bib fn =
  fn t.bib

let with_static fn =
  fn t.static

let get_fs db name =
  match Fs.t_get ~name:(`Eq name) db with
  | [] -> raise Not_found
  | [x] -> x.Fs.body
  | y -> failwith (Printf.sprintf "too many found: %s [%d] " name (List.length y))

let get_static = get_fs t.static
