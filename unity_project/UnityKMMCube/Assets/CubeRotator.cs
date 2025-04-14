using UnityEngine;

public class CubeRotator : MonoBehaviour
{
    private bool shouldRotate = false;

    void Update()
    {
        if (shouldRotate)
        {
            transform.Rotate(Vector3.up * 90f * Time.deltaTime);
        }
    }

    public void RotateFromNative()
    {
        shouldRotate = true;
        Invoke("StopRotation", 4f);
    }

    private void StopRotation()
    {
        shouldRotate = false;
    }
}
