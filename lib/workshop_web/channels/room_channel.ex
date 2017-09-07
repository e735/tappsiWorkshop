defmodule WorkshopWeb.RoomChannel do
   use WorkshopWeb, :channel

   alias Workshop.Chat
   alias Workshop.Chat.Badword # crea el alias para leer la tabla badwords
   require Logger
   
   def listanegra do
      ["puta", "marico", "marica" , "puto", "verga", "malparido", "gonorrea", "guevon", "hijoeputa", "huevon"]
      
      # crea una lista negra de palabras guardadas en la BD
      # Chat.list_badwords()
      # LA FUNCION TRAE LOS DATOS, PERO NO ENCUENTRO COMO CONVERTIRLO EN UNA LISTA DE PALABRAS

   end

   def join("room:lobby", payload, socket) do
      if authorized?(payload) do
         {:ok, socket}
      else
         {:error, %{reason: "unauthorized"}}
      end
   end

   # Channels can be used in a request/response fashion
   # by sending replies to requests from the client
   def handle_in("ping", payload, socket) do
      {:reply, {:ok, payload}, socket}
   end

   # It is also common to receive messages from the client and
   # broadcast to everyone in the current topic (room:lobby).
   def handle_in("shout", %{"user_name" => user, "user_message" => message} = payload,socket) do

      fraseFiltrada =  String.split(message, " ") # divide la frase ingresada en palabras
      |>quitarmalaspalabras("")              # verifica que las palabras no esten en la lista negra

      case Chat.create_log(%{user: user, message: fraseFiltrada}) do
         {:ok, _} ->
            #se redefinio el valor de payload para que cargara directamente en el chat
            payload =  %{"user_name" => user, "user_message" => fraseFiltrada}
            broadcast socket, "shout", payload
         {:error, _} ->
         Logger.info("Error saving with payload: #{inspect payload}")
      end
      {:noreply, socket}
   end

   # Add authorization logic here as required.
   defp authorized?(_payload) do
      true
   end
   
   # Función que verifica si una lista de palabras están en la lista negra y las reemplaza 
   # => devuelve una frase sin malas palabras
   def quitarmalaspalabras([palabra | restofrase], frase) do
      if Enum.member?(listanegra, palabra) do
         quitarmalaspalabras(restofrase, frase <> " *****")
      else
         quitarmalaspalabras(restofrase, frase <> " " <> palabra)
      end
   end

   # condición de borde de la función
   def quitarmalaspalabras([], frase) do
      frase
   end

end