
import { initializeApp } from "firebase/app";
import { createUserWithEmailAndPassword, getAuth, signInWithEmailAndPassword, signOut } from "firebase/auth/cordova";
import { addDoc, collection, getFirestore } from "firebase/firestore/lite";
import { toast } from "react-toastify";

const firebaseConfig = {
  apiKey: "AIzaSyCkf9XYMJ9BbqIQaHRQ2diHjLBm14CWsCU",
  authDomain: "netflix-clone-373bf.firebaseapp.com",
  projectId: "netflix-clone-373bf",
  storageBucket: "netflix-clone-373bf.firebasestorage.app",
  messagingSenderId: "716734773654",
  appId: "1:716734773654:web:c7518534c927bdb997c5b7"
};
const app = initializeApp(firebaseConfig);
const auth = getAuth(app);
const db = getFirestore(app);

const signup = async (name, email, password)=>{

  try {
    
    const res = await createUserWithEmailAndPassword(auth, email, password);

    const user = res.user;
    await addDoc(collection(db, "users"), {
      uid: user.uid,
      name,
      authProvider: "local",
      email,
    })

  
  } catch (error) {
    console.log(error);
    toast.error(error.code.split('/')[1].split('-').join(" "));

  
  }


}

const login = async (email, password)=>{
  try {
    await signInWithEmailAndPassword(auth, email, password);

  } catch (error) {
    console.log(error);
    toast.error(error.code.split('/')[1].split('-').join(" "));

  }

}

const logout = ()=>{
  signOut(auth);
}

export { auth, db, signup, login, logout };

