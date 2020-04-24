[Image 1](https://raw.githubusercontent.com/AchcarLucas/Engenharia-F-sica-USP-/master/PhysicSimulator/image/image_1.png)
[Image 2](https://raw.githubusercontent.com/AchcarLucas/Engenharia-F-sica-USP-/master/PhysicSimulator/image/image_2.png)

### Physic Simulador
O programa escrito em processing pode simular 2 tipos de força (Campo e Objeto)

A força aplicada a um objeto pode ser do tipo Impusivo ou Permanente
```
IMPULSE_OBJECT (Impulsivo)
PERMANENT_OBJECT (Força permanente) 
```

A força de campo é aplicado no espaço, e pode ser do tipo repulsivo ou atrativo

```
ATTRACT_FIELD (Atrativo de Campo)
REPULSE_FIELD (Repulsivo de Campo - Gravitacional)
```

Para utilizar o programa, abra o Main.pde e altere a parte do setupMain() e drawMain()

Em Main.pde a linha (4), inicializa a classe de forças, com ela que vamos adicionar os objetos e aplicar as forças

```
public classForce forces = new classForce();
```

para a  classForce só é necessário inicializar apenas uma vez

Para criar uma particula (objeto), crie com a classParticle

Ex:
```
classParticle p1 = new classParticle(particlePosition, new PVector(v*1.5f, 0.0f), particle_mass);
```

Suas funções podem ser utilizadas como abaixo:
r0_position é um PVector de posição inicial da particula em (m) (definida a posição com base no tamanho da tela)
r0_velocity é um PVector de velocidade inicial em (m/s)
r0_mass é a massa em kg
r0_name é o nome que deseja dar a particula

```
classParticle(PVector r0_position, PVector r0_velocity, float r0_mass, String r0_name)
classParticle(PVector r0_position, PVector r0_velocity, float r0_mass)
classParticle(PVector r0_position, PVector r0_velocity)
```

Agora escolha o modo de força (Campo ou Objeto)

para usar a força no objeto, utilize a classe typeForceField

Ex: 
```
typeForceField _tff1 = new typeForceField(enumForce.ATTRACT_FIELD, sunPosition, sun_mass);
typeForceObject _tfo1 = typeForceObject(enumType.REPULSE_FIELD, PVector(1,0f, 0.0f, 0.0f), 0.1f)
```

A classe typeForceField possui 2 funções de sobrescrita

```
typeForceField(enumForce type, PVector position, float mass)
typeForceField(enumForce type, PVector position)
```

enumForce é o tipo de força, como é do tipo Campo, só é possível utilizar

```
ATTRACT_FIELD ou REPULSE_FIELD
```

position é a posição da força (força de campo no espaço, definida a posição com base no tamanho da tela)
mass é a massa da particula

(Obs: A função de campo obedece as Leis de Newton) 

```
F = m*M*G / R^2
```

A classe typeForceObject possui 2 funções de sobrescrita

```
typeForceObject(enumForce type, PVector force, float t_m_impulse)
typeForceObject(enumForce type, PVector force)
```

O enumForce define o tipo de força

```
IMPULSE_OBJECT ou PERMANENT_OBJECT
```

Com todas as forças definidas, é hora de aplicar a um objeto, basta adicionar sua particula para a classe força.

```
forces.addClassObject(p1);
```

class classForce
```
ArrayList<typeForceObject> getForcesObject()
ArrayList<typeForceField> getForcesField()

void addClassObject(classObject object)
void addForceObject(typeForceObject f)
void addForceField(typeForceField f)

void removeAllClassObject()
void removeAllForcesObject()
void removeAllForcesField()

void addForceField(typeForceField f)

ArrayList<typeForceObject> getResultObjectForce()
ArrayList<typeForceField> getResultFieldForce()

void updatePhysic()
```

class typeForceField
```
typeForceField(enumForce type, PVector position, float mass)
typeForceField(enumForce type, PVector position)
PVector getPosition()
```


class typeForceObject
```
typeForceObject(enumForce type, PVector force, float t_m_impulse)
typeForceObject(enumForce type, PVector force)
```

enum enumForce
```
IMPULSE_OBJECT, ATTRACT_FIELD, REPULSE_FIELD, PERMANENT_OBJECT
```

Os parametros

```
protected float resolution = 0.01f;
protected float G = 6.67408*pow(10, -11);
```

resolution é a resolução das distâncias, quanto menor for esse valor, maior será o seu espaço, 0.01 equivale a 100km 0.001 a 1000km e assim por diante

G é a Constante Gravitacional de Newton

class classObject
```
public void updatePhysic(ArrayList<typeForceObject> fn_object, ArrayList<typeForceField> fn_field)
classObject(PVector r0_position, PVector r0_velocity, float r0_mass, String r0_name)
classObject(PVector r0_position, PVector r0_velocity, float r0_mass)
classObject(PVector r0_position, PVector r0_velocity)
PVector getPosition()
String getName()
float getAngleToVelocity()
float getAngleToResultForce()
boolean hasDestroyed()
void setDestroyed(boolean destroyed)
```

A função updatePhysic é delegada a class classForce, não chame diretamente.
Se for plotar algum objeto na tela, utilize getPosition(), pois como as distâncias são dinâmicas, as posições são relativas com base na resolução

class classParticle extends classObject
```
classParticle(PVector r0_position, PVector r0_velocity, float r0_mass, String r0_name)
classParticle(PVector r0_position, PVector r0_velocity, float r0_mass)
classParticle(PVector r0_position, PVector r0_velocity)
```

O código já possui um exemplo ;D

