# Users:
admin = User.create(email: "admin@example.com", password: "password")
dan = User.create(email: "dlleal@uc.cl", password: "password")
admin.administrator!
dan.administrator!
User.create(email: "user@example.com", password: "password")
User.create(email: "rjerez1@uc.cl", password: "password")
User.create(email: "linustorvalds@gmail.com", password: "genius")
User.create(email: "stevejobs@gmail.com", password: "windows")

# Campuses:
campus_sj = Venue.create(
  name: "Campus San Joaquín",
  address: "Av. Vicuña Mackenna 4860, Macul, Región Metropolitana",
  description: "Campus público en Macul"
)
campus_cc = Venue.create(
  name: "Campus Casa Central",
  address: "Av Libertador Bernardo O'Higgins 340, Santiago, Región Metropolitana",
  description: "Campus en Santiago"
)
campus_o = Venue.create(
  name: "Campus Oriente",
  address: "Jaime Guzmán Errázuriz 3300, Providencia, Región Metropolitana",
  description: "Campus privado en Providencia"
)
campus_lc = Venue.create(
  name: "Campus Lo Contador",
  address: "Monseñor Carlos Casanueva, Macul, Providencia, Región Metropolitana",
  description: "Campus privado en Providencia"
)
campus_v = Venue.create(
  name: "Campus Villarrica",
  address: "Bernardo O'Higgins 501, Villarrica, Región de la Araucanía",
  description: "Campus en Villarrica"
)

# Salas:
Room.create(number: "A1", venue_id: campus_sj.id)
room_a2 = Room.create(number: "A2", venue_id: campus_sj.id)
Room.create(number: "A3", venue_id: campus_sj.id)
Room.create(number: "A4", venue_id: campus_sj.id)
room_a5 = Room.create(number: "A5", venue_id: campus_sj.id)
Room.create(number: "A6", venue_id: campus_sj.id)
Room.create(number: "A7", venue_id: campus_sj.id)
Room.create(number: "C002", venue_id: campus_sj.id)
Room.create(number: "C003", venue_id: campus_sj.id)
room_al3 = Room.create(number: "AL3", venue_id: campus_sj.id)
room_al4 = Room.create(number: "AL4", venue_id: campus_sj.id)

Room.create(number: "AR4", venue_id: campus_cc.id)
Room.create(number: "AR7", venue_id: campus_cc.id)
Room.create(number: "BC1", venue_id: campus_cc.id)
Room.create(number: "ALU9", venue_id: campus_cc.id)

Room.create(number: "O1", venue_id: campus_o.id)
Room.create(number: "O2", venue_id: campus_o.id)

Room.create(number: "C1", venue_id: campus_lc.id)
Room.create(number: "C2", venue_id: campus_lc.id)
Room.create(number: "C3", venue_id: campus_lc.id)
Room.create(number: "C4", venue_id: campus_lc.id)

Room.create(number: "V1", venue_id: campus_v.id)
Room.create(number: "V2", venue_id: campus_v.id)
Room.create(number: "V3", venue_id: campus_v.id)

# Ramos:
arqui = Course.create(
  name: "Arquitectura de Computadores",
  initials: "IIC2343",
  teacher_name: "Yadran Eterovic",
  room_id: room_al4.id
)
discretas = Course.create(
  name: "Matemáticas Discretas",
  initials: "IIC1253",
  teacher_name: "Cristian Riveros",
  room_id: room_al3.id
)
