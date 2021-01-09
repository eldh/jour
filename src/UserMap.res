type t = {
  id: Credt.Util.id,
  name: string,
  email: string,
  age: int,
}

type update =
  | SetEmail(string)
  | SetName(string)
  | IncreaseAge
  | DecreaseAge
  | SetAge(int)

module Config = {
  type t = t
  type update = update
  let getId = u => u.id
  let moduleId = "UserMap" |> Credt.Util.idOfString
  let reducer = (user, x) =>
    switch x {
    | SetEmail(email) => ({...user, email: email}, SetEmail(user.email))
    | SetName(name) => ({...user, name: name}, SetName(user.name))
    | SetAge(age) => ({...user, age: age}, SetAge(user.age))
    | IncreaseAge => ({...user, age: user.age + 1}, DecreaseAge)
    | DecreaseAge => ({...user, age: user.age - 1}, IncreaseAge)
    }
}

include Credt.Map.Make(Config)

let makeUser = i => {
  id: Credt.Util.makeId(),
  name: "Name" ++ (i |> string_of_int),
  email: "email@" ++ (i |> string_of_int),
  age: i * 2,
}

let baseUser = makeUser(1)

module Context = CredtMapContext.Make({
  type t = t
  type operation = operation
  let instance = instance
})

ignore(apply(list{Add(baseUser)}))
