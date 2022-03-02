-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end



math.randomseed(love.timer.getTime())

function math.angle(x1,y1, x2,y2) return math.atan2(y2-y1, x2-x1) end

sonShoot = love.audio.newSource("sons/shoot.wav", "static")
sonExplode = love.audio.newSource("sons/explode_touch.wav", "static")


heros = {}

liste_sprites = {}
liste_tirs = {}
liste_aliens = {}


niveau = {}
table.insert(niveau, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(niveau, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(niveau, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(niveau, { 0,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(niveau, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(niveau, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(niveau, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(niveau, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(niveau, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(niveau, { 0,0,0,0,0,0,2,2,2,2,2,2,2,2,0,0 })
table.insert(niveau, { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(niveau, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(niveau, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(niveau, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(niveau, { 0,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(niveau, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(niveau, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(niveau, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(niveau, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(niveau, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(niveau, { 0,0,0,0,0,0,2,2,2,2,2,2,2,2,0,0 })
table.insert(niveau, { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(niveau, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(niveau, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(niveau, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(niveau, { 0,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(niveau, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(niveau, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(niveau, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(niveau, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(niveau, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(niveau, { 0,0,0,0,0,0,2,2,2,2,2,2,2,2,0,0 })
table.insert(niveau, { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(niveau, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(niveau, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(niveau, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(niveau, { 0,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(niveau, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(niveau, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(niveau, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(niveau, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(niveau, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(niveau, { 0,0,0,0,0,0,2,2,2,2,2,2,2,2,0,0 })
table.insert(niveau, { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(niveau, { 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3 })

imgTuiles = {}
local n
for n=1,3 do
  imgTuiles[n] = love.graphics.newImage("images/tuile_"..n..".png")
end

function collide(a1, a2)
 if (a1==a2) then return false end
 local dx = a1.x - a2.x
 local dy = a1.y - a2.y
 if (math.abs(dx) < a1.image:getWidth()+a2.image:getWidth()) then
  if (math.abs(dy) < a1.image:getHeight()+a2.image:getHeight()) then
   return true
  end
 end
 return false
end

-- Camera
camera = {}
camera.y = 0
camera.v = 1

function CreeTir(pType,pNomImage, pX, pY, pVitesseX, pVitesseY)
    local tir = CreeSprite(pNomImage, pX, pY)
    tir.vx = pVitesseX
    tir.vy = pVitesseY
    tir.type = pType
    table.insert(liste_tirs,tir)
    sonShoot:play()
end

function CreeSprite(pNomImage, pX, pY)
  
  sprite = {}
  sprite.x = pX
  sprite.y = pY
  sprite.image = love.graphics.newImage("images/"..pNomImage..".png")
  sprite.l = sprite.image:getWidth()
  sprite.h = sprite.image:getHeight()
  sprite.supprime = false
  
  table.insert(liste_sprites, sprite)
  return sprite
  
end

function CreeAlien(pType, pX, pY)
  
  nomImage = ""
  
  if pType == 1 then
    nomImage = "enemy1"
  elseif pType == 2 then
    nomImage = "enemy2"
  elseif pType == 3 then
    nomImage = "tourelle"
  end
  
  local alien = CreeSprite(nomImage, pX,pY)
  
  alien.endormi = true
  alien.type = pType
  alien.chronotir = 0
  
  if pType == 1 then
    alien.vx = 0
    alien.vy = 2
    alien.energie = 1
  elseif pType == 2 then
    alien.vy = 2
    local direction = math.random(1,2)
    if direction == 1 then
      alien.vx = 1
    else
      alien.vx = -1
    end
    alien.energie = 3
  elseif pType == 3 then
    alien.vx = 0
    alien.vy = camera.v
    alien.energie = 5
  end
  
  table.insert(liste_aliens,alien)
  
end

function love.load()
  
  love.window.setMode(1024,768)
  love.window.setTitle("Atelier Shooter GameCodeur")
  
  largeur = love.graphics.getWidth()
  hauteur = love.graphics.getHeight()
  
  heros = CreeSprite("heros", largeur/2, hauteur/2)
  
  DemarreJeu()
  
end

function DemarreJeu()
  
  heros.x = largeur/2
  heros.y = hauteur - heros.h *2
  

  local ligne = 4
  CreeAlien(1, largeur/2, -(64/2) - (64*(ligne-1)))
   
  ligne = 10
  CreeAlien(2, largeur/2, -(64/2) - (64*(ligne-1)))
  
  ligne= 11
  CreeAlien(3, 64*3, -(64/2) - (64*(ligne-1)))
  
  --Raz de la camera
  camera.y = 0
  
end

function love.update(dt)
  
  camera.y = camera.y + camera.v
  
  --Traitement des tirs
  local n
  for n= #liste_tirs,1,-1  do
    local tir = liste_tirs[n]
    tir.x = tir.x + tir.vx
    tir.y = tir.y + tir.vy
    
    --Si le heros est tourché
    if tir.type == "alien" then
      if collide(heros, tir) then
        print("Boom je suis touché!!")
        tir.supprime = true
        table.remove(liste_tirs,n)
      end
    end
    
    --Vérifie si on touche les aliens
    
  if tir.type == "heros" then
    local nAlien
     for nAlien=#liste_aliens,1,-1 do
      local alien = liste_aliens[nAlien]
        if collide(tir, alien) then
          
          tir.supprime = true
          table.remove(liste_tirs,n)
          alien.energie = alien.energie - 1
          sonExplode:play()
          if alien.energie <= 0 then
            alien.supprime = true
            table.remove(liste_aliens,nAlien)
          end
        end
      end
  end
  
     
    
    
    
    
    
    
    
     if tir.y > hauteur or tir.y < 0 then
      tir.supprime = true
      table.remove(liste_tirs,n)
    end
    
  end
  
  --Traitement des sprites
  for n=#liste_sprites,1,-1 do
    if liste_sprites[n].supprime == true then
      table.remove(liste_sprites,n)
    end
  end

  -- Traitement des aliens
  for n=#liste_aliens,1,-1 do
    local alien = liste_aliens[n]
    
    if alien.y > 0 then
      alien.endormi = false
    end
    
    if alien.endormi == false then
      alien.x = alien.x + alien.vx 
      alien.y = alien.y + alien.vy
      
      if alien.type == 1 or alien.type == 2 then
        alien.chronotir = alien.chronotir - 1
        if alien.chronotir <= 0 then
          alien.chronotir = math.random(60,100)
          CreeTir("alien","laser2", alien.x, alien.y, 0 , 10)
        end
      elseif alien.type == 3 then
        alien.chronotir = alien.chronotir - 1
        if alien.chronotir <= 0 then
          alien.chronotir = 2
          local vx,vy
          local angle
          angle = math.angle(alien.x, alien.y, heros.x, heros.y)
          vx = 10 * math.cos(angle)
          vy = 10 * math.sin(angle)
          CreeTir("alien","laser2", alien.x, alien.y, vx , vy)
        end
      end
      
    else
      alien.y = alien.y + camera.v
    end
    
    if alien.y > hauteur then
        alien.supprime = true
        table.remove(liste_aliens,n)
      end
  end
  
  
  if love.keyboard.isDown("up") and heros.y > 1 then
    heros.y = heros.y - 4
  end
  if love.keyboard.isDown("down") and heros.y < hauteur - (heros.h*2)  then
      heros.y = heros.y + 4
  end
  if love.keyboard.isDown("right") and heros.x < largeur then
    heros.x = heros.x + 4
  end
  if love.keyboard.isDown("left") and heros.x > 1 then
    heros.x = heros.x - 4
  end

end

function love.draw()

    
  local ligne,colonne
  local nbLignes =#niveau
  local x,y
  x = 0 
  y = (0 - 64) + camera.y
  for ligne= nbLignes,1,-1 do
    for colonne= 1,16 do
      local tuile = niveau[ligne][colonne]
      if tuile > 0 then
        love.graphics.draw(imgTuiles[tuile], x, y, 0, 2 ,2)
      end
      x = x + 64
    end
    x = 0
    y = y - 64
  end
  
  
  
  
  local n
  for n = #liste_sprites,1,-1 do
    local s= liste_sprites[n]
    love.graphics.draw(s.image, s.x, s.y, 0,2,2, s.l/2, s.h/2)
  end
  
  
  
  
  
  love.graphics.print("Nombre de sprites = "..#liste_sprites.."  Nombre de tirs = "..#liste_tirs.." Nombre d'aliens = "..#liste_aliens, 0,0)
  
end

function love.keypressed(key)
  if key == "space" then
    CreeTir("heros","laser1", heros.x , heros.y - heros.h, 0, -10)
  end
end
  