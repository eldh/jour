type t = {
  id: Credt.Util.id,
  name: string,
  email: string,
  age: int,
};

type update =
  | SetEmail(string)
  | SetName(string)
  | IncreaseAge
  | DecreaseAge
  | SetAge(int);

module Config = {
  type nonrec t = t;
  type nonrec update = update;
  let getId = u => u.id;
  let moduleId = "UserMap" |> Credt.Util.idOfString;
  let reducer = user =>
    fun
    | SetEmail(email) => ({...user, email}, SetEmail(user.email))
    | SetName(name) => ({...user, name}, SetName(user.name))
    | SetAge(age) => ({...user, age}, SetAge(user.age))
    | IncreaseAge => ({...user, age: user.age + 1}, DecreaseAge)
    | DecreaseAge => ({...user, age: user.age - 1}, IncreaseAge);
};

include Credt.Map.Make(Config);

let makeUser = i => {
  id: Credt.Util.makeId(),
  name: "Name" ++ (i |> string_of_int),
  email: "email@" ++ (i |> string_of_int),
  age: i * 2,
};

let baseUser = makeUser(1);

module Context =
  CredtMapContext.Make({
    type nonrec t = t;
    type nonrec operation = operation;
    let instance = instance;
  });

apply([Add(baseUser)]);
