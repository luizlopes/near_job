# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Link.create(source: 'A', target: 'B', distance: 5)
Link.create(source: 'B', target: 'C', distance: 7)
Link.create(source: 'B', target: 'D', distance: 3)
Link.create(source: 'C', target: 'E', distance: 4)
Link.create(source: 'D', target: 'E', distance: 10)
Link.create(source: 'D', target: 'F', distance: 8)

DistanceFactor.create(initial: 0, final: 5, factor: 100)
DistanceFactor.create(initial: 6, final: 10, factor: 75)
DistanceFactor.create(initial: 11, final: 15, factor: 50)
DistanceFactor.create(initial: 16, final: 20, factor: 25)
DistanceFactor.create(initial: 21, final: 999, factor: 0)

Job.create(id: 1, company: 'ACME', title: 'Engenheiro', description: 'Criar engenhocas', localization: 'A', level: 3)
Job.create(id: 2, company: 'INTEL', title: 'Técnico', description: 'Resolver tudo', localization: 'A', level: 5)

Person.create(id: 1, name: 'Luiz', career: 'Pedreiro', localization: 'C', level: 3)
Person.create(id: 2, name: 'Guilherme', career: 'Programador', localization: 'D', level: 1)