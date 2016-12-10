using UnityEngine;
using System.Collections;

public class mainSurgeonControls : MonoBehaviour {

    static Animator anim;
    public float speed = 10.0F;
    public float rotationSpeed = 100.0F;


    // Simulation Characters
    public GameObject surgeonAssistant;
    public GameObject scrubNurse;
    public GameObject anes;
    public GameObject computerWorker;

    // Sanitation Zone
    public GameObject sanitationZone;

    float dist;
    bool alter1;
    bool alter2;
    bool alter3;
    bool alter4;
    bool moveBothChars;
    AudioSource steps;
  

	// Use this for initialization
	void Start () {
        anim = GetComponent<Animator>();
        Cursor.lockState = CursorLockMode.Locked;

        surgeonAssistant = GameObject.Find("SurgeonAssistantMale");
        scrubNurse = GameObject.Find("ScrubNurse");
        anes = GameObject.Find("Anesthesiologist");
        computerWorker = GameObject.Find("ComputerWorker");
        sanitationZone = GameObject.Find("Sanitation");

        alter1 = false;
        alter2 = false;
        alter3 = false;
        alter4 = false;
        moveBothChars = false;
        steps = this.GetComponents<AudioSource>()[4];


    }
	
	// Update is called once per frame
	void Update () {

        float translation = Input.GetAxis("Vertical") * speed;
        float straffe = Input.GetAxis("Horizontal") * speed;
        translation *= Time.deltaTime;
        straffe *= Time.deltaTime;
        transform.Translate(straffe, 0, translation);

        if(Input.GetKeyDown("space"))
        {
            anim.SetTrigger("sideStep");
            
        }

        if(anim.GetCurrentAnimatorStateInfo(0).IsName("rifle_side_step"))
        {
            scrubNurse.GetComponent<Animator>().SetBool("isSideStep", true);
            scrubNurse.transform.Translate(-straffe, 0, translation);
        } else
        {
            scrubNurse.GetComponent<Animator>().SetBool("isSideStep", false);
        }





        if (Input.GetButtonDown("Fire1"))
        {
            anim.SetTrigger("moveArms");
            anim.ResetTrigger("moveArmsUp");
            
        }

        if(Input.GetButtonDown("Fire2"))
        {
            anim.SetTrigger("moveArmsUp");
            anim.ResetTrigger("moveArms");
            
        }


        if(Input.GetKeyDown("escape"))
        {
            Cursor.lockState = CursorLockMode.None;
        }

        if(translation != 0 || straffe != 0)
        {
            anim.SetBool("isWalking", true);
            
        }
        else
        {
            anim.SetBool("isWalking", false);
            steps.Stop();
        }


        if(Input.GetKey(KeyCode.W) || Input.GetKey(KeyCode.A) || Input.GetKey(KeyCode.S) || Input.GetKey(KeyCode.D))
        {
            if(!steps.isPlaying)
            {
                steps.Play();
            }
           
            
        } 


        // Check for the distance between each character in the scene
        if(surgeonAssistant != null)
        {
            dist = Vector3.Distance(this.gameObject.transform.position, surgeonAssistant.transform.position);
            // value of 1.00 <= x <= 1.25 is med prox sound
            // value of < 1.00 is a major alert
            if(dist < 1.25 && dist > 0.80 && !surgeonAssistant.GetComponents<AudioSource>()[1].isPlaying && !this.GetComponents<AudioSource>()[1].isPlaying)
            {
                if(!alter1)
                {
                    surgeonAssistant.GetComponents<AudioSource>()[1].Play();
                } else
                {
                    this.GetComponents<AudioSource>()[1].Play();
                }

                alter1 = !alter1;
                
            
           
            } else if(dist < 0.80 && !surgeonAssistant.GetComponents<AudioSource>()[0].isPlaying && !surgeonAssistant.GetComponents<AudioSource>()[1].isPlaying && !this.GetComponents<AudioSource>()[0].isPlaying)
            {

                if(!alter1)
                {
                    surgeonAssistant.GetComponents<AudioSource>()[0].Play();
                } else
                {
                    this.GetComponents<AudioSource>()[0].Play();
                }

                alter1 = !alter1;
                
               
            }


        }


        // Check for the distance between each character in the scene
        if (scrubNurse != null)
        {
            dist = Vector3.Distance(this.gameObject.transform.position, scrubNurse.transform.position);
            // value of 1.00 <= x <= 1.25 is med prox sound
            // value of < 1.00 is a major alert
            if (dist < 1.25 && dist > 0.80 && !scrubNurse.GetComponents<AudioSource>()[1].isPlaying && !this.GetComponents<AudioSource>()[1].isPlaying && !anim.GetCurrentAnimatorStateInfo(0).IsName("rifle_side_step"))
            {
                if (!alter2)
                {
                    scrubNurse.GetComponents<AudioSource>()[1].Play();
                }
                else
                {
                    this.GetComponents<AudioSource>()[1].Play();
                }

                alter2 = !alter2;


      



            }
            else if (dist < 0.80 && !scrubNurse.GetComponents<AudioSource>()[0].isPlaying && !scrubNurse.GetComponents<AudioSource>()[1].isPlaying && !this.GetComponents<AudioSource>()[0].isPlaying && !anim.GetCurrentAnimatorStateInfo(0).IsName("rifle_side_step"))
            {

                if (!alter2)
                {
                    scrubNurse.GetComponents<AudioSource>()[0].Play();
                }
                else
                {
                    this.GetComponents<AudioSource>()[0].Play();
                }

                alter2 = !alter2;

                
            } else if(anim.GetCurrentAnimatorStateInfo(0).IsName("rifle_side_step") && !this.GetComponents<AudioSource>()[3].isPlaying) /* here is the simulation for walking past by facing each other*/
            {
                float angle = 10;
                if(dist < 1.10 && Vector3.Angle(this.transform.forward, scrubNurse.transform.position - transform.position) < angle)
                {
                    this.GetComponents<AudioSource>()[3].Play();
                }
            }


        }


        // Check for the distance between each character in the scene
        if (anes != null)
        {
            dist = Vector3.Distance(this.gameObject.transform.position, anes.transform.position);
            // value of 1.00 <= x <= 1.25 is med prox sound
            // value of < 1.00 is a major alert
            if (dist < 1.25 && dist > 0.80 && !anes.GetComponents<AudioSource>()[1].isPlaying && !this.GetComponents<AudioSource>()[1].isPlaying)
            {
                if (!alter3)
                {
                    anes.GetComponents<AudioSource>()[1].Play();
                }
                else
                {
                    this.GetComponents<AudioSource>()[1].Play();
                }

                alter3 = !alter3;



            }
            else if (dist < 0.80 && !anes.GetComponents<AudioSource>()[0].isPlaying && !anes.GetComponents<AudioSource>()[1].isPlaying && !this.GetComponents<AudioSource>()[0].isPlaying)
            {

                if (!alter3)
                {
                    anes.GetComponents<AudioSource>()[0].Play();
                }
                else
                {
                    this.GetComponents<AudioSource>()[0].Play();
                }

                alter3 = !alter3;


            }


        }

        // Check for the distance between each character in the scene
        if (computerWorker != null)
        {
            dist = Vector3.Distance(this.gameObject.transform.position, computerWorker.transform.position);
            // value of 1.00 <= x <= 1.25 is med prox sound
            // value of < 1.00 is a major alert
            if (dist < 1.25 && dist > 0.80 && !computerWorker.GetComponents<AudioSource>()[1].isPlaying && !this.GetComponents<AudioSource>()[1].isPlaying)
            {
                if (!alter4)
                {
                    computerWorker.GetComponents<AudioSource>()[1].Play();
                }
                else
                {
                    this.GetComponents<AudioSource>()[1].Play();
                }

                alter4 = !alter4;



            }
            else if (dist < 0.80 && !computerWorker.GetComponents<AudioSource>()[0].isPlaying && !computerWorker.GetComponents<AudioSource>()[1].isPlaying && !this.GetComponents<AudioSource>()[0].isPlaying)
            {

                if (!alter4)
                {
                    computerWorker.GetComponents<AudioSource>()[0].Play();
                }
                else
                {
                    this.GetComponents<AudioSource>()[0].Play();
                }

                alter4 = !alter4;


            }


        }



        /* Check animation state to play sound depending on whether or not arms are below the waist */
        if(anim.GetCurrentAnimatorStateInfo(0).IsName("arms90") && !this.GetComponents<AudioSource>()[2].isPlaying && !this.GetComponents<AudioSource>()[3].isPlaying)
        {
            //play the medium alert sound
            this.GetComponents<AudioSource>()[2].Play();
        }

        if(anim.GetCurrentAnimatorStateInfo(0).IsName("arms_down45") && !this.GetComponents<AudioSource>()[2].isPlaying && !this.GetComponents<AudioSource>()[3].isPlaying)
        {
            //play the high alert sound
            this.GetComponents<AudioSource>()[3].Play();
        }

        // Re-sanitize yourself to remove sound
        if(sanitationZone != null)
        {
            dist = Vector3.Distance(this.gameObject.transform.position, sanitationZone.transform.position);
            if(dist < 7.00)
            {
                this.GetComponents<AudioSource>()[3].Stop();
            }
        }





    }
}
