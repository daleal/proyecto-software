# Users:
admin  = User.create(email: "admin@example.com", password: "password")
daniel = User.create(email: "dlleal@uc.cl", password: "password")
ariel  = User.create(email: "amartinez5@uc.cl", password: "password")
rudy   = User.create(email: "rjerez1@uc.cl", password: "password")
admin.administrator!
daniel.administrator!
user = User.create(email: "user@example.com", password: "password")
linus = User.create(email: "linustorvalds@gmail.com", password: "genius")
jobs = User.create(email: "stevejobs@gmail.com", password: "windows")

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
room_sj_a1   = Room.create(number: "A1", venue_id: campus_sj.id)
room_sj_a2   = Room.create(number: "A2", venue_id: campus_sj.id)
room_sj_a3   = Room.create(number: "A3", venue_id: campus_sj.id)
room_sj_a4   = Room.create(number: "A4", venue_id: campus_sj.id)
room_sj_a5   = Room.create(number: "A5", venue_id: campus_sj.id)
room_sj_a6   = Room.create(number: "A6", venue_id: campus_sj.id)
room_sj_a7   = Room.create(number: "A7", venue_id: campus_sj.id)
room_sj_c002 = Room.create(number: "C002", venue_id: campus_sj.id)
room_sj_c003 = Room.create(number: "C003", venue_id: campus_sj.id)
room_sj_al3  = Room.create(number: "AL3", venue_id: campus_sj.id)
room_sj_al4  = Room.create(number: "AL4", venue_id: campus_sj.id)

room_cc_b101 = Room.create(number: "B-101", venue_id: campus_cc.id)
room_cc_b102 = Room.create(number: "B-102", venue_id: campus_cc.id)
room_cc_b103 = Room.create(number: "B-103", venue_id: campus_cc.id)
room_cc_b201 = Room.create(number: "B-201", venue_id: campus_cc.id)
room_cc_b202 = Room.create(number: "B-202", venue_id: campus_cc.id)
room_cc_b203 = Room.create(number: "B-203", venue_id: campus_cc.id)

room_o_act1  = Room.create(number: "ACT1", venue_id: campus_o.id)
room_o_act2  = Room.create(number: "ACT2", venue_id: campus_o.id)
room_o_act3  = Room.create(number: "ACT3", venue_id: campus_o.id)
room_o_act4  = Room.create(number: "ACT4", venue_id: campus_o.id)
room_o_act5  = Room.create(number: "ACT5", venue_id: campus_o.id)
room_o_act6  = Room.create(number: "ACT6", venue_id: campus_o.id)
room_o_act7  = Room.create(number: "ACT7", venue_id: campus_o.id)
room_o_act8  = Room.create(number: "ACT8", venue_id: campus_o.id)
room_o_act9  = Room.create(number: "ACT9", venue_id: campus_o.id)
room_o_act10 = Room.create(number: "ACT10", venue_id: campus_o.id)

room_lc_s1 = Room.create(number: "S1", venue_id: campus_lc.id)
room_lc_s2 = Room.create(number: "S2", venue_id: campus_lc.id)
room_lc_s3 = Room.create(number: "S3", venue_id: campus_lc.id)
room_lc_s4 = Room.create(number: "S4", venue_id: campus_lc.id)
room_lc_s5 = Room.create(number: "S5", venue_id: campus_lc.id)
room_lc_s6 = Room.create(number: "S6", venue_id: campus_lc.id)

room_v_clas = Room.create(number: "CLAS", venue_id: campus_v.id)
room_v_pra  = Room.create(number: "PRA", venue_id: campus_v.id)

# Ramos:
Course.create(
  name: "Contabilidad y Control de Gestión",
  initials: "ICS2613",
  teacher_name: "Mauricio González",
  room_id: room_sj_a1.id
)
Course.create(
  name: "Optimización Bajo Incertidumbre",
  initials: "ICS3151",
  teacher_name: "Gustavo Angulo",
  room_id: room_sj_a2.id
)
Course.create(
  name: "Bases de Datos",
  initials: "IIC2413",
  teacher_name: "Adrián Soto",
  room_id: room_sj_a3.id
)
discretas = Course.create(
  name: "Matemáticas Discretas",
  initials: "IIC1253",
  teacher_name: "Cristian Riveros",
  room_id: room_sj_al3.id
)
arqui = Course.create(
  name: "Arquitectura de Computadores",
  initials: "IIC2343",
  teacher_name: "Yadran Eterovic",
  room_id: room_sj_al4.id
)

# Eventos:
of_arqui = Event.create(
  category: "Ofrezco Clases",
  description: "Hola! Recientemente boté la ayudantía de este ramo, por lo " \
               "que me encuentro listo para ganar dinero!",
  course_id: arqui.id,
  created_by: ariel.id
)
bu_discretas = Event.create(
  category: "Busco Clases",
  description: "Por favor ayuda no merezco pasar este ramo pero no me lo " \
               "quiero echar busco clases desesperadamente",
  course_id: discretas.id,
  created_by: daniel.id
)

# Publicaciones:
me_eche_discretas = Publication.create(
  title: "Me eché la I3",
  description: "Cabros, me eché la I3 con ganas jaja salu2 y vendisuone",
  publication_date: Time.current - 72.hours,
  created_by: daniel.id,
  course_id: discretas.id
)
guante_perdido_discretas = Publication.create(
  title: "Guante perdido",
  description: "Hola! Encontré un guante perdido en la sala, por si es de alguien",
  publication_date: Time.current - 8.hours,
  created_by: ariel.id,
  course_id: discretas.id
)

# Reacciones Publicaciones:
me_eche_discretas.downvote_from rudy
me_eche_discretas.upvote_from admin
me_eche_discretas.upvote_from ariel
me_eche_discretas.upvote_from user
me_eche_discretas.upvote_from linus
me_eche_discretas.upvote_from jobs
guante_perdido_discretas.upvote_from daniel


# Comentarios:
risa_discretas = me_eche_discretas.comments.create(
  content: "Jajajajaja que pena tu vida",
  comment_date: Time.current - 68.hours,
  created_by: ariel.id
)
ayuda_discretas = me_eche_discretas.comments.create(
  content: "Yo fui ayudante del ramo! Aún lo puedes salvar en el examen, yo te ayudo",
  comment_date: Time.current - 60.hours,
  created_by: rudy.id
)
guante_encontrado_discretas = guante_perdido_discretas.comments.create(
  content: "El guante es mío! me lo saqué en clases para secarme una lágrima",
  comment_date: Time.current - 7.hours - 37.minutes,
  created_by: daniel.id
)

# Reacciones Comentarios:
risa_discretas.downvote_from daniel
risa_discretas.downvote_from rudy
risa_discretas.upvote_from jobs
risa_discretas.upvote_from linus
risa_discretas.upvote_from user
ayuda_discretas.upvote_from daniel
guante_encontrado_discretas.upvote_from daniel
guante_encontrado_discretas.upvote_from admin
